OTP reading library
===================
.. rheader::

   OTP Info |version|

OTP reading library
-------------------

This module contains functions for reading board information
(e.g. serial number, MAC address) from the OTP memory of an XCore. 
This information can be written to the device using the XBURN develop
tool provider by XMOS.


Software version and dependencies
.................................

This document pertains to version |version| of the OTP reading library. It is
intended to be used with version 13.x of the xTIMEcomposer studio tools.

The library does not have any dependencies (i.e. it does not rely on any
other libraries).

API
---

The ports used by OTP memory are the same on every tile. They need to
be declared with the following type:

.. doxygenstruct:: otp_ports_t

For convenience the define ``OTP_PORTS_INITIALIZER`` is provided that
can be used to initialize a structure of this type to the correct
ports for accessing OTP e.g.::

  on stdcore[0]: otp_ports_t otp_ports = OTP_PORTS_INITIALIZER;

|newpage|

The following functions can then be used to obtain information from
the OTP that has be set via XBURN:

.. doxygenfunction:: otp_board_info_get_mac
.. doxygenfunction:: otp_board_info_get_serial
