// Copyright 2014-2021 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.
#include "otp_board_info.h"
#include <platform.h>
#include <stdio.h>

// Reads board information from the OTP of stdcore[0]. Tested on XC-3 board.

on tile[0]: otp_ports_t otp_ports = OTP_PORTS_INITIALIZER;

int main()
{
  char mac[6];
  unsigned serial;
  int hasMac = 0;
  int hasSerial = otp_board_info_get_serial(otp_ports, serial);
  for (unsigned i = 0; otp_board_info_get_mac(otp_ports, i, mac); i++) {
    int needSeparator = 0;
    hasMac = 1;
    printf("MAC Address %d: ", i);
    for (unsigned j = 0; j < 6; j++) {
      if (needSeparator)
        printf(":");
      printf("%02x", mac[j]);
      needSeparator = 1;
    }
    printf("\n");
  }
  if (hasSerial) {
    printf("Serial number: %d\n", serial);
  }
  if (!hasMac && !hasSerial) {
    printf("No board info found\n");
  }
  return 0;
}
