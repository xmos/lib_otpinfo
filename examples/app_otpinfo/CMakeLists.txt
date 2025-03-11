cmake_minimum_required(VERSION 3.21)
include($ENV{XMOS_CMAKE_PATH}/xcommon.cmake)

set(APP_PCA_ENABLE ON)
set(APP_XSCOPE_SRCS         src/config.xscope)
set(XMOS_SANDBOX_DIR        ${CMAKE_CURRENT_LIST_DIR}/../../..)
set(APP_DEPENDENT_MODULES   lib_otpinfo)

set(COMPILER_FLAGS_COMMON   -g
                            -report
                            -DDEBUG_PRINT_ENABLE
                            -Wno-reinterpret-alignment
                            )

set(ARCH xs2 xs3)

foreach(arch ${ARCH})
    if(arch STREQUAL "xs3")
        set(target XK-EVK-XU316)
    elseif(arch STREQUAL "xs2")
        set(target XCORE-200-EXPLORER)
    endif()

    project(app_otpinfo)
    set(APP_HW_TARGET          ${target})
    set(APP_COMPILER_FLAGS_${arch}     ${COMPILER_FLAGS_COMMON})
    XMOS_REGISTER_APP()
    unset(APP_COMPILER_FLAGS_${arch})
endforeach()
