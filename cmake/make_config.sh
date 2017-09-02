#!/bin/sh

# generate cmake config input
sed -e 's/^#undef *\(HAVE.*\)/#define \1 @GSL_\1@/' \
    -e 's/^#undef STDC_HEADERS/#define STDC_HEADERS @GSL_STDC_HEADERS@/' \
    ../gsl/config.h.in  > config.h.in

# generate cmake includes
cfg_entry()
{
    if [ ! -f have/$1.cmake -o ! -s have/$1.cmake ]
    then
        echo need write have/$1.cmake
        touch have/$1.cmake
    fi

    echo \# $1 >> config.cmake
    echo include\(\${SOURCE_DIR}/cmake/have/$1.cmake\) >> config.cmake
    echo >> config.cmake
}

echo \# gsl configuration\n > config.cmake
echo >> config.cmake
for f in $(sed -n 's/^#undef *\(HAVE.*\)/GSL_\1/p' ../gsl/config.h.in)
do
    cfg_entry ${f}
done

cfg_entry GSL_STDC_HEADERS