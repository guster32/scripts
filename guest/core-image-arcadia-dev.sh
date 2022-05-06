#!/bin/bash

pushd /home/builduser/meta-arcadia
git checkout .
git pull
popd

cd /home/builduser/poky
source oe-init-build-env
bitbake -c clean core-image-arcadia-dev
bitbake core-image-arcadia-dev
