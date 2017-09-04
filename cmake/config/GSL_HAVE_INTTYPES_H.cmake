check_include_files(inttypes.h GSL_HAVE_INTTYPES_H)
if (NOT GSL_HAVE_INTTYPES_H)
    set(GSL_HAVE_INTTYPES_H 0)
endif ()
