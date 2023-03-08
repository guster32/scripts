#!/bin/bash

FULL_PATH=$(dirname "$0")
SCRIPT_NAME=createArcadiaContainer-x86_64.sh

$FULL_PATH/runScript.sh $SCRIPT_NAME yocto_ubuntu_22.04 latest

ret=$?
if [ $ret -ne 0 ]
then
  echo "Error:runScript failed: $ret!!"
else
  buildah commit --format docker $SCRIPT_NAME arcadia:x86_64
  echo "runScript completed!!"
fi

podman rm $SCRIPT_NAME
