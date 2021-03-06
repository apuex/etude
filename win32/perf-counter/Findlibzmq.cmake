################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Read the zproject/README.md for information about making permanent changes. #
################################################################################

if (NOT MSVC)
    include(FindPkgConfig)
    pkg_check_modules(PC_LIBZMQ "libzmq")
    if (PC_LIBZMQ_FOUND)
        # add CFLAGS from pkg-config file, e.g. draft api.
        add_definitions(${PC_LIBZMQ_CFLAGS} ${PC_LIBZMQ_CFLAGS_OTHER})
        # some libraries install the headers is a subdirectory of the include dir
        # returned by pkg-config, so use a wildcard match to improve chances of finding
        # headers and SOs.
        set(PC_LIBZMQ_INCLUDE_HINTS ${PC_LIBZMQ_INCLUDE_DIRS} ${PC_LIBZMQ_INCLUDE_DIRS}/*)
        set(PC_LIBZMQ_LIBRARY_HINTS ${PC_LIBZMQ_LIBRARY_DIRS} ${PC_LIBZMQ_LIBRARY_DIRS}/*)
    endif(PC_LIBZMQ_FOUND)
endif (NOT MSVC)

find_path (
    LIBZMQ_INCLUDE_DIRS
    NAMES zmq.h
    HINTS ${PC_LIBZMQ_INCLUDE_HINTS}
)

find_library (
    LIBZMQ_LIBRARIES
    NAMES zmq
    HINTS ${PC_LIBZMQ_LIBRARY_HINTS}
)

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(
    LIBZMQ
    REQUIRED_VARS LIBZMQ_LIBRARIES LIBZMQ_INCLUDE_DIRS
)
mark_as_advanced(
    LIBZMQ_FOUND
    LIBZMQ_LIBRARIES LIBZMQ_INCLUDE_DIRS
)

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Read the zproject/README.md for information about making permanent changes. #
################################################################################
