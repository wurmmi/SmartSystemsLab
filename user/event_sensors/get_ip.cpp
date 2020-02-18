#include <ifaddrs.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <cstdio>
#include <cstdint>
#include <cstring>

#include <iostream>
#include <string>
#include <thread>
#include <chrono>

#include "get_ip.h"

using namespace std::literals::chrono_literals;

struct IPv4Address
{
  uint8_t segments[4];
};

IPv4Address getIPfromSystem()
{
  // drop 127.0.0.1
  static const uint32_t LOCAL_IP = 16777343;
  IPv4Address result;

  struct ifaddrs *ifAddrStruct = NULL;
  getifaddrs(&ifAddrStruct);

  for (auto ifa = ifAddrStruct; ifa != NULL; ifa = ifa->ifa_next)
  {
    if (!ifa->ifa_addr)
    {
      continue;
    }

    if (ifa->ifa_addr->sa_family == AF_INET)
    {
      auto ip = ((struct sockaddr_in *)ifa->ifa_addr)->sin_addr.s_addr;
      if (ip == LOCAL_IP)
      {
        continue;
      }

      // use the first non-local IP
      for (int i = 0; i < 4; ++i)
      {
        result.segments[i] = static_cast<uint8_t>((ip >> (i * 8)) & 0xff);
      }
      break;
    }
  }

  if (ifAddrStruct)
  {
    freeifaddrs(ifAddrStruct);
  }

  return result;
}

getIPdata_t *get_ip(int hex_index)
{
  auto ip = getIPfromSystem();

  char chars[7] = {0};
  auto s = ip.segments[hex_index];
  snprintf(chars, 6, "%d", s);

  static getIPdata_t data = {0};

  for (int i = 0; i < SEGMENT_COUNT; ++i)
  {
    bool isValidChar = (chars[i] >= '0' && chars[i] <= '9');
    data.hex_enable |= (((int)isValidChar) & 1) << (SEGMENT_COUNT - i - 1);

    if (isValidChar)
    {
      data.hex_values[i] = chars[i];
    }
    else
    {
      data.hex_values[i] = '0';
    }
  }
  return &data;
}
