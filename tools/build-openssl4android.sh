#!/bin/bash

set -u

OPENSSL_ARCH=$1
shift
ANDROID_ABI=$1
shift
TOOLCHAIN=$1
shift
SSL=$1
shift
LIB_DEST_DIR=$1

source ./_shared.sh

# Setup architectures, library name and other vars + cleanup from previous runs
LIB_NAME=$SSL
[ -d ${LIB_DEST_DIR} ] && rm -rf ${LIB_DEST_DIR}
configure_make() {
  cd $LIB_NAME
  ARCH=$1; ABI=$2;

  configure $*

  #support openssl-1.0.x
  if [[ $LIB_NAME != "openssl-1.1.*" ]]; then
    if [[ $ARCH == "android-armeabi" ]]; then
        ARCH="android-armv7"
    elif [[ $ARCH == "android64" ]]; then 
        ARCH="linux-x86_64 shared no-ssl2 no-ssl3 no-hw "
    elif [[ "$ARCH" == "android64-aarch64" ]]; then
        ARCH="android shared no-ssl2 no-ssl3 no-hw "
    fi
  fi

  #Removing -mandroid flag from Configure as this causes issues for clang
  sed -i s/-mandroid//g ./Configure

  ./Configure $ARCH \
              --prefix=${LIB_DEST_DIR} \
              no-asm \
              no-shared \
              no-unit-test
  PATH=$TOOLCHAIN_PATH:$PATH

  if make; then
    make install

  fi;

  cd -

}

configure_make "$OPENSSL_ARCH" "$ANDROID_ABI" "$TOOLCHAIN" "$SSL"
