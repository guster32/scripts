#!/bin/bash
#-vga virtio
#-display sdl,gl=on
#-drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd
#-drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS.fd
#-cdrom /home/guster32/Downloads/Fedora-Server-dvd-x86_64-39-1.5.iso

# Qemu launch
#-kernel $USER_HOME/qemux86-64/bzImage-qemux86-64.bin --append "root=/dev/sda console=ttys0 oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1"

#BOOTABLE ISO
#-cdrom /home/guster32/Downloads/ubuntu-22.04.1-desktop-amd64.iso

# USB keyboard and Mouse
#-device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/003/008 -device usb-host,hostdevice=/dev/bus/usb/003/009

USER_HOME=$HOME
sudo qemu-system-x86_64 --enable-kvm \
        -cpu IvyBridge \
        -machine type=q35,accel=kvm \
        -smp 4 \
        -drive file=$USER_HOME/qemux86-64/core-image-arcadia-dev-qemux86-64.rootfs.ext4,index=0,media=disk,format=raw \
        -m 8G \
	-device vfio-pci,host=42:00.0,x-vga=on,multifunction=on \
        -device vfio-pci,host=42:00.1 \
        -nographic \
        -vga none \
        -device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/003/010 -device usb-host,hostdevice=/dev/bus/usb/003/011 \
        -parallel none \
	-net user,hostfwd=tcp::10022-:22,hostfwd=::13000-:3000 \
        -net nic

