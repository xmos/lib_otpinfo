
################################
lib_otpinfo: OTP reading library
################################

************
Introduction
************

``lib_otpinfo`` provides functions for reading data from the one-time programmable (OTP) memory of an xCORE device.
Specifically, the provided functions enable reading the serial number, board identifier,
and Ethernet MAC addresses, if programmed into the OTP memory.
It links against the `OTP library included in he XMOS tools <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/libraries/lib-otp-api/lib-otp-api.html#lib-otp>`_
and calls its functions to read from OTP memory.
This library is for use with `xcore-200` series (XS2 architecture) or `xcore.ai` series (XS3
architecture) devices only, previous generations of `xcore` devices (i.e. XS1 architecture) are not
supported.

*****
Usage
*****

``lib_otpinfo`` is intended to be used with the `XCommon CMake <https://www.xmos.com/file/xcommon-cmake-documentation/?version=latest>`_
, the `XMOS` application build and dependency management system.

To use this library, include ``lib_otpinfo`` in the application's ``APP_DEPENDENT_MODULES`` list, for example::

    set(APP_DEPENDENT_MODULES "lib_otpinfo")

Applications should then include the ``otp_board_info.h`` header file::

  #include "otp_board_info.h"

The ports used by OTP memory are the same on every tile. They need to
be declared with the `OTPPorts type <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/libraries/lib-otp-api/lib-otp-api.html#c.OTPPorts>`_::

  on tile[0]: OTPPorts otp_ports = OTP_PORTS_INITIALIZER;

Where ``OTP_PORTS_INITIALIZER`` is the standard initialiser for the ``OTPPorts`` structure and is defined in XMOS Tools ``lib_otp``.

***
API
***


The following functions can then be used to obtain information from
the OTP that has been set via XBURN:

.. doxygenfunction:: otp_board_info_get_mac
.. doxygenfunction:: otp_board_info_get_serial
.. doxygenfunction:: otp_board_info_get_board_identifier

