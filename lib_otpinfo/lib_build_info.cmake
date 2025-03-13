set(LIB_NAME lib_otpinfo)
set(LIB_VERSION 2.2.1)
set(LIB_INCLUDES api)
set(LIB_DEPENDENT_MODULES "")
set(LIB_COMPILER_FLAGS -Os)

unset(LIBOTP_PATH)
foreach(APP_TARGET ${APP_BUILD_TARGETS})
    if(APP_BUILD_ARCH STREQUAL "xs3a")
        set(OTP_LIB "otp3")
    elseif(APP_BUILD_ARCH STREQUAL "xs2a")
        set(OTP_LIB "otp")
    else()
        message(FATAL_ERROR "Unsupported architecture ${APP_BUILD_ARCH}")
    endif()

    set(OTP_LIB_PATH "$ENV{XCC_LIBRARY_PATH}/${APP_BUILD_ARCH}")
    find_library(LIBOTP_PATH NAMES ${OTP_LIB} PATHS ${OTP_LIB_PATH})
    if(LIBOTP_PATH STREQUAL "LIBOTP_PATH-NOTFOUND")
        message(FATAL_ERROR, "${OTP_LIB} library not found")
    endif()

    set(lib_target "lib${OTP_LIB}")

    if(NOT TARGET ${lib_target})
        add_library(${lib_target} STATIC IMPORTED)
        set_target_properties(${lib_target} PROPERTIES IMPORTED_LOCATION ${LIBOTP_PATH})
    endif()

    target_link_libraries(${APP_TARGET} PRIVATE ${lib_target})
    unset(LIBOTP_PATH CACHE)

endforeach()

XMOS_REGISTER_MODULE()
