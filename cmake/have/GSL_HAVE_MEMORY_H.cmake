check_include_files(memory.h GSL_HAVE_MEMORY_H)
if (NOT GSL_HAVE_MEMORY_H)
    set(GSL_HAVE_MEMORY_H 0)
endif ()
