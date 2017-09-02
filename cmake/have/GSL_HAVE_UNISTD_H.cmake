check_include_files(unistd.h GSL_HAVE_UNISTD_H)
if (NOT GSL_HAVE_UNISTD_H)
    set(GSL_HAVE_UNISTD_H 0)
endif ()
