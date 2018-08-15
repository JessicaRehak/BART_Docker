FROM dealii/dealii:9.0.0-gcc-mpi-fulldepsspack-debugrelease

MAINTAINER jsrehak@berkeley.edu

USER root

RUN apt-get update

# Prereqs
RUN apt-get update && \
    apt-get install -y wget libopenmpi-dev openmpi-bin

# Updated CMake
RUN wget https://cmake.org/files/v3.10/cmake-3.10.3.tar.gz && \
    tar -xvf cmake-3.10.3.tar.gz && \
    cd cmake-3.10.3 && \
    ./bootstrap && \
    make -j4 && \
    make install

# Protocol Buffers

RUN wget http://github.com/google/protobuf/releases/download/v3.6.0/protobuf-cpp-3.6.0.tar.gz && \
    tar -xvf protobuf-cpp-3.6.0.tar.gz && \
    cd protobuf-3.6.0 && \
    ./configure && \
    make && \
    make check && \
    make install && \
    ldconfig

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

RUN apt-get install -y lcov

# ENV variables

ENV CC=/usr/bin/mpicc
ENV CXX=/usr/bin/mpicxx
ENV DEAL_II_DIR=/usr/local/opt/spack/linux-ubuntu16.04-x86_64/gcc-5.4.0/dealii-9.0.0-jdia334y7mn2fbccw7rfor5zf33e7jw6/
