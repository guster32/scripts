#!/bin/bash
#set -o xtrace
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
HOST_DL_DIR=$FULL_PATH/../shared/downloads
HOST_SSTATE_DIR=$FULL_PATH/../shared/sstate-cache
HOST_BUILD_DIR=$FULL_PATH/../shared/${SCRIPT_NAME%.sh}/build
HOST_TMP_DIR=$FULL_PATH/../shared/${SCRIPT_NAME%.sh}/tmp


GUEST_SCRIPT_DIR=/home/builduser/mnt/scripts
GUEST_DL_DIR=/home/builduser/mnt/downloads
GUEST_SSTATE_DIR=/home/builduser/mnt/sstate-cache
GUEST_BUILD_DIR=/home/builduser/mnt/build
GUEST_TMP_DIR=/tmp

mkdir -p $HOST_DL_DIR
mkdir -p $HOST_SSTATE_DIR
mkdir -p $HOST_BUILD_DIR
mkdir -p $HOST_TMP_DIR

chmod 777 $HOST_DL_DIR
chmod 777 $HOST_SSTATE_DIR
chmod 777 $HOST_BUILD_DIR
chmod 777 $HOST_TMP_DIR

echo "Setting up container. Please standby..."
podman run --rm --ulimit nofile=899999:899999 --pids-limit=0 -i \
  -v $HOST_SCRIPT_DIR:$GUEST_SCRIPT_DIR:Z \
  -v $HOST_DL_DIR:$GUEST_DL_DIR:Z \
  -v $HOST_SSTATE_DIR:$GUEST_SSTATE_DIR:Z \
  -v $HOST_BUILD_DIR:$GUEST_BUILD_DIR:Z \
  -v $HOST_TMP_DIR:$GUEST_TMP_DIR:Z \
  $IMG_NAME:$IMG_TAG \
  $GUEST_SCRIPT_DIR/$SCRIPT_NAME

#-v $HOST_SCRIPT_DIR/../../meta-arcadia:/home/builduser/meta-arcadia:Z
#-v $HOST_SCRIPT_DIR/../../meta-odroid:/home/builduser/meta-odroid:Z