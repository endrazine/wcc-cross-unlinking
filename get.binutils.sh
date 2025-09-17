#!/bin/bash

set -x

rm -rf binutils-temp
mkdir -p binutils-temp
cd binutils-temp
wget -N -c https://sourceware.org/pub/binutils/releases/binutils-2.45.tar.xz

tar -xvJf binutils-2.45.tar.xz

rm -rf ./build/
mkdir build -p
cd build
../binutils-2.45/configure --with-sysroot=/ --enable-shared --enable-targets=all --build=x86_64-linux-gnu --host=x86_64-linux-gnu --enable-plugins --prefix=/usr --enable-ld=default --enable-gold --enable-multilib build_alias=x86_64-linux-gnu host_alias=x86_64-linux-gnu

make -j8

make install

# Copy missing bfd.h header (missing in binutils 2.xx)
cp ./bfd/bfd.h /usr/include/

cp ./libctf/.libs/libctf.so.0.0.0 /usr/lib/x86_64-linux-gnu/libctf.so.0.0.0
cp ./libctf/.libs/libctf.so.0.0.0 /usr/lib/x86_64-linux-gnu/libctf-nobfd.so.0

cp ./libsframe/.libs/libsframe.so.2.0.0 /usr/lib/libsframe.so.2.0.0
ln -s /usr/lib/libsframe.so.2.0.0 /usr/lib/libsframe.so.2
ln -s /usr/lib/libsframe.so.2.0.0 /usr/lib/libsframe.so

cp ./opcodes/.libs/libopcodes-2.45.so /usr/lib/libopcodes-2.45.so
cp ./bfd/.libs/libbfd-2.45.so /usr/lib/libbfd-2.45.so

rm /usr/lib/libbfd.so -f
ln -s /usr/lib/libbfd-2.45.so /usr/lib/libbfd.so

rm /usr/lib/libopcodes.so -f
ln -s /usr/lib/libopcodes-2.45.so /usr/lib/libopcodes.so

ldconfig
