check_include_files(strings.h GSL_HAVE_STRINGS_H)
if (NOT GSL_HAVE_STRINGS_H)
    set(GSL_HAVE_STRINGS_H 0)
endif ()
