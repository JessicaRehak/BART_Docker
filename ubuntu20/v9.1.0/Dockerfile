FROM ubuntu:focal

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

# Install dealii-v.9.1.0
RUN wget https://github.com/dealii/candi/archive/v9.1.1-r2.tar.gz && \
    tar -xvf v9.1.1-r2.tar.gz
RUN cd $HOME/candi-9.1.1 && \
    ./candi.sh -j4 \
    	--packages="load:dealii-prepare once:dealii" \
        --prefix=$HOME/dealii \
	--platform=./deal.II-toolchain/platforms/supported/ubuntu18.platform
RUN rm -rf $HOME/candi-9.1.1 $HOME/dealii/tmp	       

ENV DEAL_II_DIR $HOME/dealii/deal.II-v9.1.1

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

# # Protocol Buffers
RUN wget http://github.com/protocolbuffers/protobuf/releases/download/v3.11.2/protobuf-cpp-3.11.2.tar.gz && \
    tar -xvf protobuf-cpp-3.11.2.tar.gz && \
    cd protobuf-3.11.2 && \
    ./configure && \
    make && \
    make check && \
    sudo make install && \
    sudo ldconfig && \
    cd ~ && \
    rm protobuf-cpp-3.11.2.tar.gz && \
    rm -rf protobuf-3.11.2
