#!/bin/bash

FULL_PATH=$(dirname "$0")
QEMU_IMG=qemux86-64
IMAGE_RECIPE=core-image-arcadia-dev
SCRIPT_NAME=$IMAGE_RECIPE-sdk.sh
SDK_FILE=arcadia-glibc-x86_64-$IMAGE_RECIPE-core2-64-$QEMU_IMG-toolchain-1.0.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME arcadia x86_64

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$SDK_FILE
  podman cp $SCRIPT_NAME:/home/builduser/poky/build/tmp/deploy/sdk/$SDK_FILE $HOME/
  echo "runScript completed!!"
fi

podman rm $SCRIPT_NAME
