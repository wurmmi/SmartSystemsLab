/*
 * Terasic DE1-SoC Sensor Driver for Infrared (IR) Sensor
 *
 * Copyright (C) 2020 Michael Wurm <michael.wurm@students.fh-hagenberg.at>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/of.h>
#include <linux/io.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/uaccess.h>
#include <linux/interrupt.h>
#include <linux/ioctl.h>
#include <linux/sched/signal.h>

#define DRIVER_NAME "infrared"

#define SIGNAL_EVENT 12 // User space has to listen for this event number (SIGUSR2)

#define NUM_TIMESTAMPS 256
#define NUM_BYTE_TIMESTAMP_DATA (NUM_TIMESTAMPS * sizeof(uint32_t))
#define NUM_BYTE_MAGIC_NRS (4 * sizeof(uint32_t))
#define NUM_BYTE_IRQS_ACTIVE (sizeof(uint32_t))

#define SIZEOF_DATA_T (NUM_BYTE_TIMESTAMP_DATA + \
                       NUM_BYTE_MAGIC_NRS)

#define MEM_OFFSET_DATA_MAGIC_NR0 (NUM_BYTE_TIMESTAMP_DATA + 0x0)
#define MEM_OFFSET_DATA_MAGIC_NR1 (NUM_BYTE_TIMESTAMP_DATA + 0x4)
#define MEM_OFFSET_DATA_MAGIC_NR2 (NUM_BYTE_TIMESTAMP_DATA + 0x8)
#define MEM_OFFSET_DATA_MAGIC_NR3 (NUM_BYTE_TIMESTAMP_DATA + 0xC)
#define MEM_OFFSET_DATA_IRQ (NUM_BYTE_TIMESTAMP_DATA + 0x10)

/* IO Control (IOCTL) */
#define IOC_SET_PID 0
#define IOC_CMD_SET_PID _IO(4711, IOC_SET_PID)

typedef struct
{
  uint32_t timestamp[NUM_TIMESTAMPS];
  uint32_t magic_number[4];
} __attribute__((packed)) buffer_t;

struct data
{
  void *regs;
  buffer_t buffer_data;
  uint32_t pid;
  uint32_t mode;
  uint32_t size;
  uint32_t irq_nr;
  uint32_t irq_count;
  uint32_t irqs_active;
  struct miscdevice misc;
};

static irqreturn_t irq_handler(int nr, void *data_ptr)
{
  struct data *dev = data_ptr;
  struct siginfo info;
  struct task_struct *t;

  pr_info("INFRARED Interrupt occured.\n");

  /* Determine which interrupt occured */
  dev->irqs_active = ioread32(dev->regs + MEM_OFFSET_DATA_IRQ);

  if (dev->irqs_active == 0x1)
  {
    dev->irq_count++;
    pr_info("INFRARED Received interrupt [Occured %i times so far.]\n", dev->irq_count);
  }
  else
  {
    /* Another device asserted the shared interrupt line */
    pr_info("INFRARED Shared interrupt wasn't me.");
    return IRQ_NONE;
  }

  /* Send signal to user space */
  t = pid_task(find_vpid(dev->pid), PIDTYPE_PID);
  if (t == NULL)
  {
    printk(KERN_ERR "A Task with PID %i does not exist.\n", dev->pid);
    return IRQ_HANDLED;
  }

  memset(&info, 0, sizeof(struct siginfo));
  info.si_signo = SIGNAL_EVENT;
  info.si_code = SI_QUEUE;
  info.si_int = 4711;

  send_sig_info(SIGNAL_EVENT, &info, t);

  return IRQ_HANDLED;
}

/*
 * @brief This function gets executed on fread.
 */
static int dev_read(struct file *filep, char *buf, size_t count,
                    loff_t *offp)
{
  struct data *dev = container_of(filep->private_data,
                                  struct data, misc);
  int i;

  if (SIZEOF_DATA_T != sizeof(dev->buffer_data))
  {
    printk(KERN_ERR "Data struct buffer_t is not allocated as expected.\n");
    return -ENOEXEC;
  }

  /* check out of bound access */
  if ((*offp < 0) || (*offp >= SIZEOF_DATA_T))
    return 0;

  /* limit number of readable bytes to maximum which is still possible */
  if ((*offp + count) > SIZEOF_DATA_T)
    count = SIZEOF_DATA_T - *offp;

  // Read timestamps from FPGA RAM
  for (i = 0; i < NUM_TIMESTAMPS; i++)
  {
    dev->buffer_data.timestamp[i] = ioread32(dev->regs + i * 4);
  }

  dev->buffer_data.magic_number[0] = ioread32(dev->regs + MEM_OFFSET_DATA_MAGIC_NR0);
  dev->buffer_data.magic_number[1] = ioread32(dev->regs + MEM_OFFSET_DATA_MAGIC_NR1);
  dev->buffer_data.magic_number[2] = ioread32(dev->regs + MEM_OFFSET_DATA_MAGIC_NR2);
  dev->buffer_data.magic_number[3] = ioread32(dev->regs + MEM_OFFSET_DATA_MAGIC_NR3);

  /* copy data from kernel space buffer into user space */
  if (count > 0)
    count = count - copy_to_user(buf, (char *)&dev->buffer_data + *offp, count);

  *offp += count;

  return count;
}

/*
 * @brief This function gets executed on ioctl.
 */
static long dev_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
{
  struct data *dev = container_of(filep->private_data, struct data, misc);

  switch (cmd)
  {
  case IOC_CMD_SET_PID:
    /* Get the PID of the currently executing process.
     * The `current` variable is defined in linux/sched/signal.h */
    dev->pid = task_pid_nr(current);
    pr_info("dev_ioctl: Set current PID to %i.\n", dev->pid);
    break;
  default:
    /* it seems like ioctl is also called for all invocations of fread with cmd 0x5041 (TCGETS) */
    // pr_info("dev_ioctl: Unknown cmd (%u). Exit.\n", cmd);
    break;
  }
  return 0;
}

static const struct file_operations dev_fops = {
    .owner = THIS_MODULE,
    .read = dev_read,
    .unlocked_ioctl = dev_ioctl};

static int dev_probe(struct platform_device *pdev)
{
  struct data *dev;
  struct resource *io;
  int retval;

  /* Allocate memory for private data */
  dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
  if (dev == NULL)
    return -ENOMEM;
  platform_set_drvdata(pdev, dev);

  /* Get resources */
  io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  dev->regs = devm_ioremap_resource(&pdev->dev, io);
  if (IS_ERR(dev->regs))
    return PTR_ERR(dev->regs);

  dev->size = io->end - io->start + 1;
  dev->misc.name = DRIVER_NAME;
  dev->misc.minor = MISC_DYNAMIC_MINOR;
  dev->misc.fops = &dev_fops;
  dev->misc.parent = &pdev->dev;
  retval = misc_register(&dev->misc);
  if (retval)
  {
    dev_err(&pdev->dev, "Register misc device failed!\n");
    return retval;
  }

  /* Get interrupt */
  dev->irq_nr = platform_get_irq(pdev, 0);
  retval = devm_request_irq(&pdev->dev, dev->irq_nr, &irq_handler,
                            IRQF_SHARED, dev_name(&pdev->dev), dev);
  if (retval != 0)
  {
    dev_err(&pdev->dev, "Request interrupt failed!\n");
    return retval;
  }

  /* Enable interrupt generation in FPGA device */
  // iowrite32(0x3, dev->regs + MEM_OFFSET_BUF_IEN);

  dev_info(&pdev->dev, "Infrared (IR) sensor driver loaded!");

  return 0;
}

static int dev_remove(struct platform_device *pdev)
{
  struct data *dev = platform_get_drvdata(pdev);

  /* Disable interrupt generation in FPGA device */
  // iowrite32(0x0, dev->regs + MEM_OFFSET_BUF_IEN);
  devm_free_irq(&pdev->dev, dev->irq_nr, dev);

  misc_deregister(&dev->misc);
  platform_set_drvdata(pdev, NULL);

  return 0;
}

static const struct of_device_id dev_of_match[] = {
    {
        .compatible = "wur,infrared-1.0",
    },
    {},
};
MODULE_DEVICE_TABLE(of, dev_of_match);

static struct platform_driver dev_driver = {
    .driver = {
        .name = DRIVER_NAME,
        .owner = THIS_MODULE,
        .of_match_table = of_match_ptr(dev_of_match),
    },
    .probe = dev_probe,
    .remove = dev_remove,
};

module_platform_driver(dev_driver);

MODULE_AUTHOR("M.Wurm");
MODULE_DESCRIPTION("Altera/Terasic Infrared (IR) sensor driver");
MODULE_LICENSE("GPL v2");
