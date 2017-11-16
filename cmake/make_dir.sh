#!/bin/sh

ALL=$(grep '^ *SUBDIRS *= *' ../gsl/Makefile.am | sed 's/^ *SUBDIRS *= *//')

echo \# gsl directories > dir.cmake
echo >> dir.cmake

cblas_entry()
{
    if [ ! -f dir/cblas.cmake -o ! -s dir/cblas.cmake ]
    then
        F=$(grep '^ *libgslcblas_la_SOURCES *= *' ../gsl/cblas/Makefile.am | sed 's/^ *libgslcblas_la_SOURCES *= *//')
        SRC=
        for f in ${F}
        do
            SRC="${SRC} gsl/cblas/${f}"
        done

        echo dir entry: cblas
        echo \# cblas sources > dir/cblas.cmake
        echo source_group\(cblas FILES ${SRC}\) >> dir/cblas.cmake
        echo set\(CBLAS_SRC ${SRC}\) >> dir/cblas.cmake
        echo >> dir/cblas.cmake
    fi

    echo \# cblas >> dir.cmake
    echo include\(\${SOURCE_DIR}/cmake/dir/cblas.cmake\) >> dir.cmake
    echo >> dir.cmake
}

dir_entry()
{
    if [ ! -f dir/$1.cmake -o ! -s dir/$1.cmake ]
    then
        F=$(grep '^ *lib.*_la_SOURCES *= *' ../gsl/$1/Makefile.am | sed 's/^ *lib.*_la_SOURCES *= *//')
        SRC=
        for f in ${F}
        do
            SRC="${SRC} gsl/$1/${f}"
        done

        echo dir entry: $1
        echo \# $1 sources > dir/$1.cmake
        echo source_group\($1 FILES ${SRC}\) >> dir/$1.cmake
        echo list\(APPEND GSL_SRC ${SRC}\) >> dir/$1.cmake
        echo >> dir/$1.cmake
    fi

    echo \# $1 >> dir.cmake
    echo include\(\${SOURCE_DIR}/cmake/dir/$1.cmake\) >> dir.cmake
    echo >> dir.cmake
}

for d in ${ALL}
do
    if [ "${d}" = "cblas" ]
    then
        cblas_entry
    else
        dir_entry ${d}
    fi
done
