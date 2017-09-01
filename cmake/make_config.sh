#!/bin/sh

# generate cmake config input
sed 's/^#undef *\(HAVE.*\)/#define \1 @GSL_\1@/' ../gsl/config.h.in  > config.h.in

# generate cmake includes
echo \# gsl configuration > config.cmake
for f in $(sed -n 's/^#undef *\(HAVE.*\)/GSL_\1/p' ../gsl/config.h.in)
do
    if [ ! -f ${f}.cmake -o -s ${f}.cmake ]
    then
        echo need write have/${f}.cmake
        touch have/${f}.cmake
    fi
    
    echo \# ${f} >> config.cmake
    echo set\(${f} 0\) >> config.cmake
    echo include\(\${SOURCE_DIR}/cmake/have/${f}.cmake\) >> config.cmake
    echo >> config.cmake
done