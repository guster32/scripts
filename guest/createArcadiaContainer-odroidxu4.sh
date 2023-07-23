#!/bin/bash

git clone -b kirkstone --depth=1 https://github.com/guster32/meta-arcadia.git /home/builduser/meta-arcadia
git clone -b master --depth=1 https://github.com/meta-rust/meta-rust.git /home/builduser/meta-rust
git clone -b kirkstone --depth=1 https://github.com/kraj/meta-clang.git /home/builduser/meta-clang
git clone -b kirkstone --depth=1 https://github.com/guster32/meta-odroid.git /home/builduser/meta-odroid
cd /home/builduser/poky
source oe-init-build-env
cp /home/builduser/mnt/odroidxu4_bblayers.conf /home/builduser/poky/build/conf/bblayers.conf
cp /home/builduser/mnt/odroidxu4_local.conf /home/builduser/poky/build/conf/local.conf
bitbake core-image-arcadia-dev --runall=fetch
bitbake core-image-arcadia-dev
