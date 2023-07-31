#!/bin/bash

FULL_PATH=$(dirname "$0")
IMG=core-image-arcadia-dev-odroid-xu4.wic.xz
#SDK_FILE=arcadia-glibc-x86_64-$IMAGE_RECIPE-core2-64-$QEMU_IMG-toolchain-1.0.sh
SCRIPT_NAME=buildArcadiaDevOdroidxu4.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 latest

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$IMG
  #rm -rf $HOME/$SDK_FILE
  #cp ../shared/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/odroid-xu4/$IMG $HOME/
  #podman cp ../shared/${SCRIPT_NAME%.sh}build/tmp-glibc/deploy/sdk/$SDK_FILE $HOME/
  echo "runScript completed!!"
fi
