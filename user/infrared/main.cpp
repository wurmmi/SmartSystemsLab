#include "fpga.h"

#include <mqtt/client.h>
#include <libfpgaregion.h>

#include <iostream>
#include <string>
#include <chrono>
#include <optional>
#include <sstream>

using namespace std::literals::chrono_literals;

struct INFRARED
{
  uint32_t timestamp[256];
  uint32_t magic_number[4];
} __attribute__((packed));

std::optional<INFRARED> readFromCDev()
{
  static const std::string CHARACTER_DEVICE = "/dev/infrared";

  INFRARED results;

  // lock fpga device using a lock guard
  // the result is never used, but it keeps the mutex locked until it goes out of scope
  auto _lck = lockFPGA();

  // open character device
  auto fd = fopen(CHARACTER_DEVICE.c_str(), "rb");
  if (!fd)
  {
    std::cerr << "Failed to open character device '" << CHARACTER_DEVICE << "'" << std::endl;
    return {};
  }

  if (fread(&results, sizeof(INFRARED), 1, fd) != 1)
  {
    std::cerr << "Failed to read sensor values" << std::endl;
    (void)fclose(fd);
    return {};
  }

  (void)fclose(fd);

  return std::make_optional(results);
}

std::string formatDataToString(INFRARED payload)
{
  std::stringstream ss;
  ss << "magic_number[0]: 0x" << std::hex << payload.magic_number[0] << std::endl;
  ss << "magic_number[1]: 0x" << std::hex << payload.magic_number[1] << std::endl;
  ss << "magic_number[2]: 0x" << std::hex << payload.magic_number[2] << std::endl;
  ss << "magic_number[3]: 0x" << std::hex << payload.magic_number[3] << std::endl;
  for (int i = 0; i < 10; i++)
    ss << "timestamp[" << i << "]=" << std::hex << payload.timestamp[i] << std::endl;

  return ss.str();
}

int main()
{
  try
  {
    initFPGA("INFRARED");
  }
  catch (const std::string &s)
  {
    std::cerr << "Failed to initialize FPGA: " << s << std::endl;
    return -1;
  }

  while (1)
  {
    std::this_thread::sleep_for(1000ms);

    auto optValues = readFromCDev();
    if (!optValues.has_value())
    {
      std::cerr << "INFRARED Failed to read device." << std::endl;
      continue;
    }

    auto values = optValues.value();
    std::cout << formatDataToString(values) << std::endl;
  }

  return 0;
}
