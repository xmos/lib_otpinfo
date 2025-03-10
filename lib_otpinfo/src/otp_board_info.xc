// Copyright 2014-2025 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

#include "otp_board_info.h"
#include <xs1.h>
#include <xclib.h>
#include <stdio.h>

typedef struct board_info_header_t {
  unsigned address;
  unsigned bitmap;
} board_info_header_t;

/// Read a word from the specified address in the OTP.
static unsigned otp_read_word(OTPPorts &ports, unsigned address)
{
  unsigned value;
#if defined(__XS3A__)
  otp_read_differential(ports, address, &value, 1);
#else
  otp_read(ports, address, &value, 1);
#endif
  return value;
}

/// Search the end of the OTP for a valid board info header.
static int otp_board_info_get_header(OTPPorts &ports,
                                     board_info_header_t &info)
{
#if defined(__XS3A__)
  int address = 0x1fa;
#else
  int address = (OTP_SIZE) - 1;
#endif
  do {
    unsigned bitmap = otp_read_word(ports, address);
    unsigned length;
    // Stop if bitmap has not been written.
    if (bitmap >> 31)
      return 0;
    // If bitmap is valid we are done.
    if (bitmap >> 30) {
      info.address = address;
      info.bitmap = bitmap;
      return 1;
    }
    // Otherwise skip this bitmap and continue searching.
    length = (bitmap >> 25) & 0x1f;
    if (length == 0) {
      // Bailout on invalid length to avoid infinite loop.
      return 0;
    }
    address -= length;
  } while (address >= 0);
  // Got to the start of the OTP without finding a header.
  return 0;
}

static unsigned otp_board_info_get_num_macs(const board_info_header_t &info)
{
  return (info.bitmap >> 22) & 0x7;
}

int otp_board_info_get_mac(OTPPorts &ports, unsigned i, char mac[6])
{
  unsigned address;
  unsigned macaddr[2];
  board_info_header_t info;
  if (!otp_board_info_get_header(ports, info))
  {
    return 0;
  }
  if (i >= otp_board_info_get_num_macs(info))
  {
    return 0;
  }
  address = info.address - (2 + 2 * i);
  macaddr[0] = byterev(otp_read_word(ports, address + 1));
  macaddr[1] = byterev(otp_read_word(ports, address));
  // Assumes little endian byte order.
  for (unsigned i = 0; i < 6; i++) {
    mac[i] = (macaddr, char[])[i + 2];
  }
  return 1;
}

static int otp_board_info_has_serial(const board_info_header_t &info)
{
  return (info.bitmap >> 21) & 1;
}

static int otp_board_info_has_board_identifier(const board_info_header_t &info)
{
  return (info.bitmap >> 20) & 1;
}

int otp_board_info_get_serial(OTPPorts &ports, unsigned &value)
{
  unsigned address;
  board_info_header_t info;
  if (!otp_board_info_get_header(ports, info))
  {
    return 0;
  }
  if (!otp_board_info_has_serial(info))
  {
    return 0;
  }
  address = info.address - (otp_board_info_get_num_macs(info) * 2 + 1);
  value = otp_read_word(ports, address);
  return 1;
}

int otp_board_info_get_board_identifier(OTPPorts &ports, unsigned &value)
{
  unsigned address;
  board_info_header_t info;
  if (!otp_board_info_get_header(ports, info))
  {
    return 0;
  }
  if (!otp_board_info_has_board_identifier(info))
  {
    return 0;
  }
  address = info.address - ((otp_board_info_get_num_macs(info) * 2) + otp_board_info_has_serial(info) + 1);
  value = otp_read_word(ports, address);
  return 1;
}
