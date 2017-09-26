#!/bin/sh

# generate cmake config input
sed -e 's/^#undef *\(HAVE.*\)/#define \1 @GSL_\1@/' \
    -e 's/^#undef STDC_HEADERS/#define STDC_HEADERS @GSL_STDC_HEADERS@/' \
    ../gsl/config.h.in  > config.h.in

# generate cmake includes
config_entry()
{
    if [ ! -f config/$1.cmake -o ! -s config/$1.cmake ]
    then
        echo config entry: $1
        touch config/$1.cmake
    fi

    echo \# $1 >> config.cmake
    echo include\(\${SOURCE_DIR}/cmake/config/$1.cmake\) >> config.cmake
    echo if \(NOT $1\) >> config.cmake
    echo "    set($1 0)" >> config.cmake
    echo endif \(\) >> config.cmake
    echo >> config.cmake
}

echo \# gsl configuration > config.cmake
echo >> config.cmake
for f in $(sed -n 's/^#undef *\(HAVE.*\)/GSL_\1/p' ../gsl/config.h.in)
do
    config_entry ${f}
done

config_entry GSL_STDC_HEADERS