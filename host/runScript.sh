#!/bin/bash

SCRIPT_NAME=$1

if [ -z $SCRIPT_NAME ]; then
    echo "Error: Script name to execute is a required argument. Scripts cand be found on the guest directory."
    exit 1
fi

HOST_SCRIPT_DIR=$HOME/git/guster32/scripts/guest
GUEST_SCRIPT_DIR=/home/builduser/mnt
IMG_NAME=arcadia
IMG_TAG=x86_64
podman --storage-opt overlay.mount_program=/usr/bin/fuse-overlayfs \
  --storage-opt overlay.mountopt=nodev,metacopy=on,noxattrs=1 \
  run --name $SCRIPT_NAME -i \
  -v $HOST_SCRIPT_DIR:$GUEST_SCRIPT_DIR:Z $IMG_NAME:$IMG_TAG \
  $GUEST_SCRIPT_DIR/$SCRIPT_NAME

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  echo "runScript completed!!"
fi

podman rm $SCRIPT_NAME






