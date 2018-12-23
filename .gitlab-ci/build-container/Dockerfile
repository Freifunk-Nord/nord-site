FROM debian:stretch

RUN apt-get update && apt-get install -y \
    git \
    subversion \
    python \
    build-essential \
    gawk \
    unzip \
    time \
    libncurses5-dev \
    zlib1g-dev \
    libssl1.0-dev \
    wget \
    curl \
    openssh-client
RUN apt-get update && apt-get install -y \
    cmake \
    make \
    pkg-config && \
    cd ~ && \
    git clone http://git.universe-factory.net/libuecc && \
    cd libuecc && \
    cmake ./ && \
    make && \
    make install && \
    ldconfig && \
    cd ~ && \
    git clone https://github.com/tcatm/ecdsautils.git && \
    cd ecdsautils && \
    git checkout tags/v0.3.2 && \
    mkdir build && \
    cd build/ && \
    cmake ../ && \
    make && \
    make install && \
    cd ~ && \
    rm -rf ~/libuecc && \
    rm -rf ~/ecdsautils
