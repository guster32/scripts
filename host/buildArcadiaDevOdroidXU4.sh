#!/bin/bash

FULL_PATH=$(dirname "$0")
IMG=core-image-arcadia-dev-odroid-xu4.rootfs.wic.xz
IMG_MAP=core-image-arcadia-dev-odroid-xu4.rootfs.wic.bmap
SDK_FILE=oecore-core-image-arcadia-dev-x86_64-cortexa15t2hf-neon-vfpv4-odroid-xu4-toolchain-1.0.sh
SCRIPT_NAME=buildArcadiaDevOdroidxu4.sh
IMG_DIR="${HOME}/odroidxu4"
SDK_DIR="${HOME}/odroidxu4_sdk"

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 nanbield

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  rm -rf $IMG_DIR
  rm -rf $SDK_DIR
  mkdir -p $IMG_DIR
  mkdir -p $SDK_DIR
  cp ../.build/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/odroid-xu4/$IMG $IMG_DIR
  cp ../.build/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/images/odroid-xu4/$IMG_MAP $IMG_DIR
  cp ../.build/${SCRIPT_NAME%.sh}/build/tmp-glibc/deploy/sdk/$SDK_FILE $SDK_DIR/
  echo "sudo bmaptool copy --bmap core-image-arcadia-dev-odroid-xu4.rootfs.wic.bmap core-image-arcadia-dev-odroid-xu4.rootfs.wic.xz  /dev/[USB_BLOCK]\n" >> $IMG_DIR/readme
  echo "wpa_passphrase [SSID] >> /etc/wpa_supplicant.conf" >> $IMG_DIR/readme
  echo "...type in the passphrase and hit enter..."  >> $IMG_DIR/readme
  echo "systemctl enable network-wireless@[wireless-if].service" >> $IMG_DIR/readme
  echo "runScript completed!!"
fi
