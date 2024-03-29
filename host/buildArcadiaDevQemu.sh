#!/bin/bash

FULL_PATH=$(dirname "$0")
IMG=qemux86-64
SDK_FILE=oecore-core-image-arcadia-dev-x86_64-core2-64-qemux86-64-toolchain-1.0.sh
SCRIPT_NAME=buildArcadiaDevQemu.sh
IMG_DIR="${HOME}/${IMG}"
SDK_DIR="${HOME}/${IMG}_sdk"

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 nanbield

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$IMG_DIR
  rm -rf $HOME/$SDK_DIR
  mkdir -p $SDK_DIR
  cp -r ../.build/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/$IMG $HOME/
  cp ../.build/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/sdk/$SDK_FILE $SDK_DIR/
  echo "runScript completed!!"
fi
