#!/bin/bash
set -x

podman run --rm -it -v /$HOME/share:/home/builduser/share arcadia:qemu_x86_64 /bin/bash