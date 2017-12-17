#!/bin/bash
set -x

# get current script path and use it as the base directory

SCRIPT=$(readlink -f "$0")

export BASE_DIR=$(dirname "$SCRIPT")

# export BUILD_DIR=$BASE_DIR/build
export RPI_ROOT=$BASE_DIR/rpi

export BUILD_DIR=$RPI_ROOT/build

# clean raspberry root?

if true; then

    rm -Rf $RPI_ROOT
    mkdir -p $RPI_ROOT
    cd $RPI_ROOT

    qemu-debootstrap --foreign --arch armhf jessie $RPI_ROOT http://ftp.debian.org/debian


    chroot $RPI_ROOT apt -q -y --force-yes install build-essential
    chroot $RPI_ROOT apt -q -y --force-yes install cmake coreutils
fi

# clean build?
if true; then

    rm -Rf $BUILD_DIR
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR

    git clone https://github.com/jcurl/SerialPortStream.git sps
    cd sps
    git checkout release/2.1.2.0
    git submodule update --init --recursive

fi

cd $BUILD_DIR/sps

if true; then

    echo "todo"
    cp $BASE_DIR/do_build.sh $RPI_ROOT/build/sps/dll/serialunix
    chroot $RPI_ROOT /build/sps/dll/serialunix/do_build.sh

fi

echo Built.