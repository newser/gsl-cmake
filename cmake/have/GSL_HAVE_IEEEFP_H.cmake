check_include_files(ieeefp.h GSL_HAVE_IEEEFP_H)
if (NOT GSL_HAVE_IEEEFP_H)
    set(GSL_HAVE_IEEEFP_H 0)
endif ()
