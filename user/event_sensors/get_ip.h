#ifndef GET_IP_H
#define GET_IP_H

static const std::string CHARACTER_DEVICE = "/dev/sevensegment";
static const int SEGMENT_COUNT = 6;

struct getIPdata_t
{
  uint8_t hex_values[SEGMENT_COUNT];
  uint8_t hex_enable;
};

getIPdata_t *get_ip(int hex_index);

#endif // GET_IP_H
