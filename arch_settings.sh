#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc
echo -e "\e[33;1mRemove the \"#\" of the \"en_US.UTF-8\" line\e[0m"
sleep 10
emacs /etc/locale.gen
locale-gen
echo "KEYMAP=fr" > /etc/vconsole.conf
export KEYMAP=fr
echo "Archlinux" > /etc/hostname
mkinitcpio -P
echo -e "\e[33;1mWrite \"root\"\e[0m"
passwd
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sudo groupadd adm
sudo groupadd managers
sudo groupadd epitech
sudo useradd -m -G adm,epitech -s /bin/bash leslie
sudo useradd -m -G managers,epitech -s /bin/bash romain
echo -e "\e[33;1mWrite \"leslie\"\e[0m"
sudo passwd leslie
echo -e "\e[33;1mWrite \"romain\"\e[0m"
sudo passwd romain
echo -e "\e[33;1mAdd under the line \"root ALL=(ALL:ALL) ALL\" this \"romain ALL=(ALL:ALL) NOPASSWD: ALL\"\e[0m"
sleep 10
EDITOR=emacs visudo
NetworkManager
systemctl enable NetworkManager
systemctl enable lightdm
echo -e "\e[34;1mPlease take a snapshot\e[0m"
echo -e "\e[34;1mSettings finished\e[0m"
echo -e "\e[34;1mPlease execute \"exit\", then \"umount -R /mnt\" and then \"shutdown now\"\e[0m"
echo -e "\e[34;1mPlease read the README to find out more\e[0m"
