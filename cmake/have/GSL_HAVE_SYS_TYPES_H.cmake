check_include_files(sys/types.h GSL_HAVE_SYS_TYPES_H)
if (NOT GSL_HAVE_SYS_TYPES_H)
    set(GSL_HAVE_SYS_TYPES_H 0)
endif ()
