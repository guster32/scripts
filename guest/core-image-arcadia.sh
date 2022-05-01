#!/bin/bash

pushd /home/builduser/meta-arcadia
git stash
git pull
git stash pop
popd

cd /home/builduser/poky
source oe-init-build-env
bitbake core-image-arcadia