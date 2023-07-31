#!/bin/bash

FULL_PATH=$(dirname "$0")
QEMU_IMG=qemux86-64
SDK_FILE=arcadia-glibc-x86_64-core-image-arcadia-dev-core2-64-qemux86-64-toolchain-1.0.sh
SCRIPT_NAME=buildArcadiaDevQemu.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 latest

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$QEMU_IMG
  rm -rf $HOME/$SDK_FILE
  cp -r ../shared/${SCRIPT_NAME%.sh}/build/tmp/deploy/images/$QEMU_IMG $HOME/
  cp ../shared/${SCRIPT_NAME%.sh}/build/tmp/deploy/sdk/$SDK_FILE $HOME/
  echo "runScript completed!!"
fi
