check_include_files(dlfcn.h GSL_HAVE_DLFCN_H)
if (NOT GSL_HAVE_DLFCN_H)
    set(GSL_HAVE_DLFCN_H 0)
endif ()
