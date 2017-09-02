if (CMAKE_SYSTEM_NAME MATCHES Linux AND CMAKE_SYSTEM_PROCESSOR MATCHES sparc)
    set(GSL_HAVE_GNUSPARC_IEEE_INTERFACE 1)
endif ()

if (NOT GSL_HAVE_GNUSPARC_IEEE_INTERFACE)
    set(GSL_HAVE_GNUSPARC_IEEE_INTERFACE 0)
endif ()
