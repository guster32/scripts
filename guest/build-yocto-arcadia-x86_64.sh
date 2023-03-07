#!/bin/bash

cd /home/builduser/poky
source oe-init-build-env
cp /home/builduser/mnt/qemux86_64_bblayers.conf /home/builduser/poky/build/conf/bblayers.conf
cp /home/builduser/mnt/qemux86_64_local.conf /home/builduser/poky/build/conf/local.conf
bitbake core-image-arcadia-dev --runall=fetch
bitbake core-image-arcadia-dev
