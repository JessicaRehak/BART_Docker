FROM dealii/dealii:9.0.0-gcc-mpi-fulldepsspack-debugrelease

MAINTAINER jsrehak@berkeley.edu

USER root

RUN apt-get update

# Prereqs
RUN apt-get update && \
    apt-get install -y wget

# Protocol Buffers

RUN wget http://github.com/google/protobuf/releases/download/v3.6.0/protobuf-cpp-3.6.0.tar.gz && \
    tar -xvf protobuf-cpp-3.6.0.tar.gz && \
    cd protobuf-3.6.0 && \
    ./configure && \
    make && \
    make check && \
    make install && \
    ldconfig

RUN ln -s $(spack location --install-dir cmake)/bin/cmake /usr/local/bin/cmake

# GTest and GMock
RUN wget http://github.com/google/googletest/archive/release-1.8.0.tar.gz && \
    tar -xvf release-1.8.0.tar.gz && \
    cd googletest-release-1.8.0 && \
    cmake . && \
    make && \
    cp -r googlemock/include/* /usr/local/include && \
    cp -r googletest/include/* /usr/local/include && \
    cd googlemock && cp *.a /usr/local/lib && \
    cd gtest && cp *.a /usr/local/lib

RUN apt-get install -y lcov && \
    apt-get install -y ssh

# GCC-8

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
    apt-get install -y gcc-8 g++-8 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 1 --slave /usr/bin/g++ g++ /usr/bin/g++-8  

# ENV variables

RUN ln -s $(spack location --install-dir openmpi)/bin/mpicc /usr/local/bin/mpicc
RUN ln -s $(spack location --install-dir openmpi)/bin/mpicxx /usr/local/bin/mpicxx
RUN ln -s $(spack location --install-dir openmpi)/bin/mpirun /usr/local/bin/mpirun
RUN ln -s $(spack location --install-dir dealii) ~/dealii.9

ENV CC mpicc
ENV CXX mpicxx
ENV DEAL_II_DIR ~/dealii.9


