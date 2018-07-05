FROM jsrehak/bart-gtest

MAINTAINER jsrehak@berkeley.edu

RUN wget http://github.com/google/protobuf/releases/download/v3.6.0/protobuf-cpp-3.6.0.tar.gz
    tar -xvf protobuf-cpp-3.6.0.tar.gz
    cd protobuf-3.6.0
    ./configure
    make
    make check
    sudo make install
