FROM ubuntu:bionic

MAINTAINER jsrehak@berkeley.edu

# Set Locale information
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install basic packages
RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    gcc \
    gfortran \
    git \
    gsl-bin \
    libblas-dev \
    libboost-all-dev \
    libgsl-dev \
    liblapack-dev \
    openmpi-bin \
    libopenmpi-dev \
    sudo \
    wget \
    zlib1g-dev

# Set up user
ARG USER=bart
RUN adduser --disabled-password --gecos '' $USER
RUN adduser $USER sudo; echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
ENV HOME /home/$USER
RUN chown -R $USER:$USER /home/$USER

# Environment variables
ENV CC mpicc
ENV CXX mpicxx

# Change to user bart
USER $USER
WORKDIR $HOME

# GTest and GMock
RUN wget http://github.com/google/googletest/archive/release-1.8.0.tar.gz && \
    tar -xvf release-1.8.0.tar.gz && \
    cd googletest-release-1.8.0 && \
    cmake . && \
    make && \
    sudo cp -r googlemock/include/* /usr/local/include && \
    sudo cp -r googletest/include/* /usr/local/include && \
    cd googlemock && \
    sudo cp *.a /usr/local/lib && \
    cd gtest && \
    sudo cp *.a /usr/local/lib && \
    # Cleanup
    cd ~ && \
    rm release-1.8.0.tar.gz && \
    rm -rf googletest-release-1.8.0

# # Protocol Buffers
RUN wget http://github.com/google/protobuf/releases/download/v3.6.0/protobuf-cpp-3.6.0.tar.gz && \
    tar -xvf protobuf-cpp-3.6.0.tar.gz && \
    cd protobuf-3.6.0 && \
    ./configure && \
    make && \
    make check && \
    sudo make install && \
    sudo ldconfig && \
    cd ~ && \
    rm protobuf-cpp-3.6.0.tar.gz && \
    rm -rf protobuf-3.6.0

# dealii dependencies
RUN sudo apt-get install -y \
    libp4est-dev \
    petsc-dev \
    slepc-dev

# Install dealii
RUN git clone https://github.com/dealii/candi && \
    cd candi && \
    ./candi.sh -j4 \
    	--packages="load:dealii-prepare once:dealii" \
        --prefix=$HOME/dealii \
	--platform=./deal.II-toolchain/platforms/supported/ubuntu18.platform && \
    rm -rf $HOME/candi $HOME/dealii/tmp	       

ENV DEAL_II_DIR $HOME/dealii/deal.II-v9.0.1

RUN sudo apt-get install -y lcov

