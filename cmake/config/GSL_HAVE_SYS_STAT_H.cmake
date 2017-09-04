check_include_files(sys/stat.h GSL_HAVE_SYS_STAT_H)
if (NOT GSL_HAVE_SYS_STAT_H)
    set(GSL_HAVE_SYS_STAT_H 0)
endif ()
