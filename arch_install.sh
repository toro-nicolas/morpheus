#!/bin/bash

echo -e "\e[34;1mStarting Archlinux installation...\e[0m"
echo -e "\e[33;1mPlease enter : \"n\", \"p\", enter, enter, \"+15G\" and \"w\"\e[0m"
fdisk /dev/sda
timedatectl
pvcreate /dev/sda1
vgcreate vg1 /dev/sda1
lvcreate -L 400M -n boot vg1
lvcreate -L 9G -n root vg1
lvcreate -L 5G -n home vg1
lvcreate -L 500M -n swap vg1
mkfs.ext2 /dev/vg1/boot
mkfs.ext4 /dev/vg1/root
mkfs.ext4 /dev/vg1/home
mkswap /dev/vg1/swap
swapon /dev/vg1/swap
mount /dev/vg1/root /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/vg1/home /mnt/home
mount /dev/vg1/boot /mnt/boot
reflector --country France --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
pacstrap -K /mnt base linux linux-firmware networkmanager nano emacs zsh lvm2 grub xfce4 xfce4-goodies lightdm lightdm-gtk-greeter xorg iw wpa_supplicant dialog sudo kdb openssh
genfstab -U /mnt >> /mnt/etc/fstab
curl -o /mnt/arch_settings.sh  https://github.com/toro-nicolas/morpheus/arch_settings.sh
chmod +x /mnt/arch_settings.sh
echo -e "\e[34;1mInstallation finished\e[0m"
echo -e "\e[34;1mPlease execute \"arch-chroot /mnt /bin/bash\" and after execute \"./arch_settings.sh\"\e[0m"
