// Copyright 2014-2025 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.
#include "otp_board_info.h"
#include <platform.h>
#include <stdio.h>

// Reads board information from the OTP of stdcore[0].

on tile[0]: OTPPorts otp_ports = OTP_PORTS_INITIALIZER;

int main()
{
  char mac[6];
  unsigned serial;
  int hasMac = 0;
  int hasSerial = otp_board_info_get_serial(otp_ports, serial);
  printf("hasSerial = %d\n", hasSerial);
  if(hasSerial)
  {
    printf("Serial number = 0x%x\n", serial);
  }

  unsigned board_identifier;
  int hasBoardIdentifier = otp_board_info_get_board_identifier(otp_ports, board_identifier);
  printf("hasBoardIdentifier = %d\n", hasBoardIdentifier);
  if(hasBoardIdentifier)
  {
    printf("Board identifier = 0x%x\n", board_identifier);
    printf("Board family = 0x%02x, Board name = 0x%02x\n", (board_identifier >> 16) & 0xff, (board_identifier >> 8) & 0xff);
  }

  for (unsigned i = 0; otp_board_info_get_mac(otp_ports, i, mac); i++) {
    int needSeparator = 0;
    hasMac = 1;
    if(!i)
    {
      printf("hasMac = %d\n", hasMac);
    }
    printf("MAC Address %d: ", i);
    for (unsigned j = 0; j < 6; j++) {
      if (needSeparator)
        printf(":");
      printf("%02x", mac[j]);
      needSeparator = 1;
    }
    printf("\n");
  }
  if(!hasMac)
  {
    printf("hasMac = %d\n", hasMac);
  }

  if (!hasMac && !hasSerial && !hasBoardIdentifier) {
    printf("No board info found\n");
  }
  return 0;
}
