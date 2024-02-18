#!/bin/bash

qemu-system-x86_64 --enable-kvm \
        -cpu IvyBridge \
        -machine type=q35,accel=kvm \
        -smp 4 \
        -kernel $HOME/qemux86-64/bzImage-qemux86-64.bin --append "root=/dev/sda console=ttys0 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1" \
        -drive file=$HOME/qemux86-64/core-image-arcadia-dev-qemux86-64.rootfs.ext4,index=0,media=disk,format=raw \
        -device AC97 \
        -m 8G \
	-vga virtio \
        -usb \
        -device usb-tablet \
        -display sdl,gl=on \
        -parallel none \
        -serial stdio \
	-net user,hostfwd=tcp::10022-:22,hostfwd=::13000-:3000 \
        -net nic

