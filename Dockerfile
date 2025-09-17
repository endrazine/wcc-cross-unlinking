FROM ubuntu:24.04

RUN apt update && apt upgrade -y

RUN apt install -y wine

RUN apt install -y build-essential wget gcc make

WORKDIR /root/

COPY ./get.binutils.sh /root/

RUN chmod 0755 get.binutils.sh

RUN bash ./get.binutils.sh

COPY ./testcases/ /root/

RUN apt-get install -y clang libbfd-dev uthash-dev libelf-dev libcapstone-dev  libreadline-dev libiberty-dev libgsl-dev build-essential git debootstrap file cargo openssh-server apache2 nginx gcc
RUN apt-get install -y libbpf1 libtirpc-dev

# Build wcc & install it
RUN git clone https://github.com/endrazine/wcc.git && cd wcc && git checkout 83bc06c12a2cce715888040355cee2a92727305b && git submodule init && git submodule update && make && make install

RUN apt install -y gcc-mingw-w64-x86-64-win32

RUN make getwcc

RUN make
