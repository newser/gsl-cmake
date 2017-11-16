#!/bin/sh

ALL=$(grep '^ *SUBDIRS *= *' ../gsl/Makefile.am | sed 's/^ *SUBDIRS *= *//')

echo \# gsl directories > test.cmake
echo >> test.cmake

echo \#!/bin/sh > test.sh
echo >> test.sh

dir_entry()
{
    if [ ! -f test/$1.cmake -o ! -s test/$1.cmake ]
    then
        F=$(grep '^ *test_SOURCES *= *' ../gsl/$1/Makefile.am | sed 's/^ *test_SOURCES *= *//')
        SRC=
        for f in ${F}
        do
            SRC="${SRC} gsl/$1/${f}"
        done

        echo test entry: $1
        echo \# $1 test sources > test/$1.cmake
        if [ ! -z "${SRC}" ]
        then
            echo add_gsl_test\($1 ${SRC}\) >> test/$1.cmake
            echo >> test/$1.cmake

            echo echo testing $1 >> test.sh
            echo ./$1 >> test.sh
            echo >> test.sh
        fi
    fi

    echo \# $1 >> test.cmake
    echo include\(\${SOURCE_DIR}/cmake/test/$1.cmake\) >> test.cmake
    echo >> test.cmake
}

for d in ${ALL}
do
    dir_entry ${d}
done
