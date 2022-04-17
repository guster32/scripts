#!/bin/bash

podman machine start &>/dev/null

# Connect to the VM with reverse proxy
PORT=$(podman machine --log-level=debug ssh -- exit 2>&1 | grep Executing | awk {'print $8'})

# Mount the host filesystem to the guest
#ssh -i ~/.ssh/podman-machine-default -R 10000:$(hostname):22 -p $PORT core@localhost
ssh -i ~/.ssh/podman-machine-default -R 10000:$(hostname):22 -p $PORT core@localhost "sshfs -p 10000 $USER@127.0.0.1:/Users /mnt/Users"


