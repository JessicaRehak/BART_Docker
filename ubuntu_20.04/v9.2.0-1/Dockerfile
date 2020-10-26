FROM ubuntu:focal

MAINTAINER jsrehak@berkeley.edu

# Set Locale information
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV TZ America/New_York
ARG DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update && \
    apt-get install -y \
    cmake \
    g++ \
    gcc \
    gfortran \
    git \
    gsl-bin \
    lcov \
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

# dealii dependencies
RUN sudo apt-get install -y \
    libp4est-dev \
    petsc-dev \
    slepc-dev \
    libmetis-dev

# Install dealii-v.9.2.0
RUN git clone --single-branch --branch dealii-9.2 https://github.com/dealii/candi 
RUN cd $HOME/candi && \
    ./candi.sh -j4 \
        --platform=deal.II-toolchain/platforms/supported/ubuntu20.platform \
    	--packages="load:dealii-prepare once:dealii" \
        --prefix=$HOME/dealii
RUN rm -rf $HOME/candi $HOME/dealii/tmp	       

ENV DEAL_II_DIR $HOME/dealii/deal.II-v9.2.0

# Protocol Buffers
RUN wget http://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protobuf-cpp-3.13.0.tar.gz && \
    tar -xvf protobuf-cpp-3.13.0.tar.gz && \
    cd protobuf-3.13.0 && \
    ./configure && \
    make && \
    make check && \
    sudo make install
RUN sudo ldconfig && \
    cd ~ && \
    rm protobuf-cpp-3.13.0.tar.gz && \
    rm -rf protobuf-3.13.0

# GTest and GMock
RUN wget http://github.com/google/googletest/archive/release-1.10.0.tar.gz && \
    tar -xvf release-1.10.0.tar.gz && \
    cd googletest-release-1.10.0 && \
    cmake . && \
    make && \
    sudo cp -r googlemock/include/* /usr/local/include && \
    sudo cp -r googletest/include/* /usr/local/include && \
    cd lib && \
    sudo cp *.a /usr/local/lib && \
    # Cleanup
    cd ~ && \
    rm release-1.10.0.tar.gz && \
    rm -rf googletest-release-1.10.0

# FFTW
RUN wget http://www.fftw.org/fftw-3.3.8.tar.gz && \
    tar -xvf fftw-3.3.8.tar.gz && \
    cd fftw-3.3.8 && \
    ./configure --enable-mpi && \
    make && \
    sudo make install && \
    cd ~ && \
    rm fftw-3.3.8.tar.gz && \
    rm -rf fftw-3.3.8
    
