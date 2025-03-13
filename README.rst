:orphan:

################################
lib_otpinfo: OTP reading library
################################

:vendor: XMOS
:version: 2.2.1
:scope: General Use
:description: OTP reading library
:category: General Purpose
:keywords: OTP
:devices: xcore.ai, xcore-200

*******
Summary
*******

``lib_otpinfo`` contains functions for reading board information (e.g. serial number, MAC address)
from the one-time programmable (OTP) memory of an xCORE. This information can be written to the device using the `XBURN <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/cmd-line-tools/xburn-manual/xburn-manual.html#xburn>`_
develop tool provided by XMOS.

********
Features
********

* Read board information if present in the OTP
* Uses `lib_otp from XMOS tools <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/libraries/lib-otp-api/lib-otp-api.html#lib-otp>`_

************
Known issues
************

  * Compiling using legacy `XCOMMON build system <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/xcommon/index.html>`_ only supported for XS2 architecture (`xcore-200` series)

****************
Development repo
****************

  * `lib_otpinfo <https://github.com/xmos/lib_otpinfo>`_

**************
Required tools
**************

  * XMOS XTC Tools: 15.3.1

*********************************
Required libraries (dependencies)
*********************************

  * None

*************************
Related application notes
*************************

  * None

*******
Support
*******

This package is supported by XMOS Ltd. Issues can be raised against the software at: http://www.xmos.com/support
