#!/bin/bash

qemu-system-x86_64 \
	-cpu IvyBridge -machine q35 -smp 4 \
	-kernel $HOME/qemux86-64/bzImage--5.14.21+git0+f9e349e174_9d5572038e-r0-qemux86-64-20220416063356.bin \
	--append "root=/dev/sda oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1" \
	-drive file=$HOME/qemux86-64/core-image-arcadia-qemux86-64-20220416095151.rootfs.ext4,index=0,media=disk,format=raw
	-device AC97 -m 8G -vga virtio -usb -device usb-tablet -display default
