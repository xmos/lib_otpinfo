.. include:: ../../../README.rst

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

|appendix|

Known Issues
------------

No known issues.

.. include:: ../../../CHANGELOG.rst
