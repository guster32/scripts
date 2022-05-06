#!/bin/bash

pushd /home/builduser/meta-arcadia
git checkout .
git pull
git stash pop
popd

cd /home/builduser/poky
source oe-init-build-env
bitbake -c clean core-image-arcadia
bitbake core-image-arcadia