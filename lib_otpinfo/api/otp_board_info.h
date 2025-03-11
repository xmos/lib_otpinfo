// Copyright 2014-2025 XMOS LIMITED.
// This Software is subject to the terms of the XMOS Public Licence: Version 1.

/**
 * Functions for reading board information (serial number, MAC address).
 * from the OTP memory of an XCore. This information can be written to the
 * device using XBURN.
 */

#include <xccompat.h>

#ifndef _otp_board_info_h_
#define _otp_board_info_h_

#if defined(__XS2A__)
#include <otp.h>
#elif defined(__XS3A__)
#include <otp3.h>
#else
#error "otp_board_info.xc Unsupported architecture. XS2A and XS3A supported"
#endif

#define otp_ports_t OTPPorts // To maintain backwards compatibility

/**
 * Read a MAC address from the board information written at the end of the OTP
 * memory.
 * \param ports Ports used to access the OTP memory.
 * \param index Index of the MAC address to retrieve.
 * \param mac Array to write the MAC address to.
 * \return Returns 1 on finding a mac address at index 'index', 0 if no mac address present
 */
int otp_board_info_get_mac(REFERENCE_PARAM(OTPPorts, ports), unsigned index,
                           char mac[6]);

/**
 * Read a serial number from the board information written at the end of the OTP
 * memory.
 * \param ports Ports used to access the OTP memory.
 * \param value Variable to store the serial number to.
 * \return Returns 1 if serial number present in the OTP memory, 0 if no serial number found.
 */
int otp_board_info_get_serial(REFERENCE_PARAM(OTPPorts, ports),
                              REFERENCE_PARAM(unsigned, value));

/**
 * Read the board identifier from the board information written at the end of the OTP
 * memory.
 * \param ports Ports used to access the OTP memory.
 * \param value Variable to store the board identifier to.
 * \return Returns 1 if bitmap present in the OTP memory, 0 if no serial number found.
 */
int otp_board_info_get_board_identifier(REFERENCE_PARAM(OTPPorts, ports),
                                        REFERENCE_PARAM(unsigned, value));

#endif /* _otp_board_info_h_ */

