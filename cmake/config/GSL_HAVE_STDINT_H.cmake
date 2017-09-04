check_include_files(stdint.h GSL_HAVE_STDINT_H)
if (NOT GSL_HAVE_STDINT_H)
    set(GSL_HAVE_STDINT_H 0)
endif ()
