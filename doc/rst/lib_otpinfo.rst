
################################
lib_otpinfo: OTP reading library
################################

************
Introduction
************

``lib_otpinfo`` provides functions for reading data from the one-time programmable (OTP) memory of an xCORE device.
OTP memory contains some global information about the chip behaviour, and optionally code and data that can be used for, for example, secure boot.
Refer to the device datasheets for `xcore-200 <https://www.xmos.com/download/XE216-512-TQ128-Datasheet(1.6).pdf>`_
and `xcore.ai <https://www.xmos.com/download/XU316-1024-QF60A-xcore_ai-Datasheet(26).pdf>`_ for
more details about the OTP memory on these specific platforms.

The functions provided in ``lib_otpinfo`` enable reading the serial number, board identifier,
and Ethernet MAC addresses, if programmed into the OTP memory.

This information is configured at the top of the OTP memory, starting at logical address 0x7FF and decreasing for xcore-200 and starting at
logical address 0x1FA and decreasing for xcore.ai series devices.

Address 0x7FF (or 0x1FA for xcore.ai) contains the bitmap described in :numref:`bitmap_format_table`

.. _bitmap_format_table:

.. list-table:: Bitmap format
   :widths: 10 15 60
   :header-rows: 1

   * - Bitfield
     - Name
     - Description
   * - [31]
     - validFlag
     - If ==0, this structure has been written and should be processed
   * - [30]
     - newbitmapFlag
     - If ==0, this bitmap is now invalid, and a new bitmap should be processed which follows the structure below
   * - [25:29]
     - headerLength
     - Length of structure in words (including bitmap) rounded up to the next even number
   * - [22:24]
     - numMac
     - Number of MAC addresses that follow this bitmap (0-7), default = 0.
   * - [21]
     - serialFlag
     - if ==1, Board serial number follows bitmap
   * - [20]
     - boardIDFlag
     - If == 1, XMOS Board Identifier follows bitmap
   * - [0:19]
     - undefined
     - set to 1

The contents of the bitmap determine the data that follows it. An example of bitmap and data following it is shown in :numref:`bitmap_plus_data`:

.. _bitmap_plus_data:

.. list-table:: XMOS device information in OTP
   :widths: 10 10
   :header-rows: 1

   * - Address
     - Data
   * - 0x7FF
     - bitmap
   * - 0x7FE
     - MAC0_0
   * - 0x7FD
     - MAC0_1
   * - 0x7FC
     - MAC1_0
   * - 0x7FB
     - MAC1_1
   * - 0x7FA
     - SerialNumber
   * - 0x7F9
     - Board Identifier

``lib_otpinfo`` links against the `OTP library included in the XMOS tools <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/libraries/lib-otp-api/lib-otp-api.html#lib-otp>`_
and calls its functions to read from the OTP memory.
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

.. warning::

  To maintain backwards compatibility, the ``module_build_info`` that is required for compiling with the legacy
  `XCOMMON build system <https://www.xmos.com/documentation/XM-014363-PC/html/tools-guide/tools-ref/xcommon/index.html>`_ remains part of the library.

  However, it only has support for compiling for the XS2 architecture (`xcore-200` series). When compiling for XS3 architecture (`xcore.ai` series), build
  using XCommon CMake. This will use ``lib_build_info.cmake`` which supports both XS2 and XS3 architectures.

***
API
***


The following functions can then be used to obtain information from
the OTP that has been set via XBURN:

.. doxygenfunction:: otp_board_info_get_mac
.. doxygenfunction:: otp_board_info_get_serial
.. doxygenfunction:: otp_board_info_get_board_identifier

