#!/bin/bash

git clone -b kirkstone --depth=1 https://github.com/guster32/meta-arcadia.git /home/builduser/meta-arcadia
cd /home/builduser/poky
source oe-init-build-env
cp /home/builduser/mnt/qemux86_64_bblayers.conf /home/builduser/poky/build/conf/bblayers.conf
cp /home/builduser/mnt/qemux86_64_local.conf /home/builduser/poky/build/conf/local.conf
bitbake core-image-arcadia-dev --runall=fetch
bitbake core-image-arcadia-dev
