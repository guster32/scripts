#!/bin/bash

FULL_PATH=$(dirname "$0")
IMG=core-image-arcadia-dev-odroid-xu4.wic.xz
IMG_MAP=core-image-arcadia-dev-odroid-xu4.wic.bmap
SDK_FILE=oecore-x86_64-cortexa15t2hf-neon-vfpv4-toolchain-nodistro.0.sh 
SCRIPT_NAME=buildArcadiaDevOdroidxu4.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 latest

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $HOME/$IMG
  rm -rf $HOME/$IMG_MAP
  rm -rf $HOME/$SDK_FILE
  cp ../shared/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/odroid-xu4/$IMG $HOME/
  cp ../shared/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/odroid-xu4/$IMG_MAP $HOME/
  cp ../shared/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/sdk/$SDK_FILE $HOME/
  echo "runScript completed!!"
fi
