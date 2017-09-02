check_include_files(stdlib.h GSL_HAVE_STDLIB_H)
if (NOT GSL_HAVE_STDLIB_H)
    set(GSL_HAVE_STDLIB_H 0)
endif ()
