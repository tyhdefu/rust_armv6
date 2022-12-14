FROM rust:1.65.0-slim

# Prevent any error messages about there not being a terminal
ENV DEBIAN_FRONTEND noninteractive
# Allow pkg-config to find 
ENV PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig
# RPI tools dir
ENV RPI_TOOLS=/rpi_tools

# OpenSSL
ENV OPEN_SSL_CROSSCOMP_DIR=/rpi_tools/parm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin
ENV OPENSSL_SOURCE_DIR=/openssl-source
ENV OPENSSL_DIR=/openssl

# Enable the armhf arch
RUN dpkg --add-architecture armhf

RUN apt-get update && apt-get install -y wget

RUN rustup target add arm-unknown-linux-gnueabihf
# Create a gcc to cross compile for the raspberry pi.
RUN wget https://github.com/Pro/raspi-toolchain/releases/latest/download/raspi-toolchain.tar.gz && \
    tar xfz raspi-toolchain.tar.gz --strip-components=1 -C /opt && \
    rm raspi-toolchain.tar.gz

ENV CC=gcc
ENV TARGET_CC=/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gcc
