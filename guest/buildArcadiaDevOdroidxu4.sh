#!/bin/bash

git clone -b mickledore --depth=1 https://github.com/guster32/meta-arcadia.git /home/builduser/meta-arcadia
git clone -b mickledore --depth=1 https://github.com/guster32/meta-odroid.git /home/builduser/meta-odroid

cd /home/builduser/poky
source oe-init-build-env /home/builduser/mnt/build
cp /home/builduser/mnt/scripts/odroidxu4_bblayers.conf /home/builduser/mnt/build/conf/bblayers.conf
cp /home/builduser/mnt/scripts/odroidxu4_local.conf /home/builduser/mnt/build/conf/local.conf

bitbake core-image-arcadia-dev
bitbake core-image-arcadia-dev -c populate_sdk
