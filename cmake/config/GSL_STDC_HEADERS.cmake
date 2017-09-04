check_include_files(stdio.h GSL_STDC_HEADERS)
if (NOT GSL_STDC_HEADERS)
    set(GSL_STDC_HEADERS 0)
endif ()
