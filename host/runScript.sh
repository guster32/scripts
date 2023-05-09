#!/bin/bash

SCRIPT_NAME=$1
IMG_NAME=$2
IMG_TAG=$3
FULL_PATH=$(dirname "$0")

if [ -z $SCRIPT_NAME ]; then
    echo "Error: Script name is a required argument. Scripts cand be found on the guest directory."
    exit 1
fi

if [ -z $IMG_NAME ]; then
    echo "Error: Container name is a required argument. Container name can be found by running podman/docker images."
    exit 1
fi

if [ -z $IMG_TAG ]; then
    echo "Error: Container tag is a required argument. Container tag can be found by running podman/docker images."
    exit 1
fi

HOST_SCRIPT_DIR=$FULL_PATH/../guest
GUEST_SCRIPT_DIR=/home/builduser/mnt

podman --storage-opt overlay.mount_program=/usr/bin/fuse-overlayfs \
  --storage-opt overlay.mountopt=nodev,metacopy=on,noxattrs=1 \
  run --ulimit nofile=65535:65535 --pids-limit=0 --name $SCRIPT_NAME -i \
  -v $HOST_SCRIPT_DIR:$GUEST_SCRIPT_DIR:Z $IMG_NAME:$IMG_TAG \
  $GUEST_SCRIPT_DIR/$SCRIPT_NAME
