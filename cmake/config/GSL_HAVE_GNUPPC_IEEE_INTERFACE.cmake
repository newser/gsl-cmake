if (CMAKE_SYSTEM_NAME MATCHES Linux AND CMAKE_SYSTEM_PROCESSOR MATCHES powerpc)
    set(GSL_HAVE_GNUPPC_IEEE_INTERFACE 1)
endif ()
