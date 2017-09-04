check_include_files(string.h GSL_HAVE_STRING_H)
if (NOT GSL_HAVE_STRING_H)
    set(GSL_HAVE_STRING_H 0)
endif ()
