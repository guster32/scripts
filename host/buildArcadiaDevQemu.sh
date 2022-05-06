#!/bin/bash

FULL_PATH=$(dirname "$0")
QEMU_IMG=qemux86-64
SCRIPT_NAME=core-image-arcadia-dev.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME arcadia x86_64

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$QEMU_IMG
  podman cp $SCRIPT_NAME:/home/builduser/poky/build/tmp/deploy/images/$QEMU_IMG $HOME/
  echo "runScript completed!!"
fi

podman rm $SCRIPT_NAME
