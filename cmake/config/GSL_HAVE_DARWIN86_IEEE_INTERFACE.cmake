if (CMAKE_SYSTEM_NAME STREQUAL Darwin)
    set(cpu ${CMAKE_SYSTEM_PROCESSOR})
    string(TOLOWER ${cpu} cpu)
    if (cpu MATCHES "(.*intel.*|.*amd.*|.*x64.*|.*x86.*|.*i.86)")
        set(GSL_HAVE_DARWIN86_IEEE_INTERFACE 1)
    endif ()
endif ()

