# Morpheus

## VM Config
- Iso de Archlinux
- RAM : 4096MB
- ROM : 32GB
- 2 coeurs
- Disable EFI
- Network : NAT (default)

## Archlinux

### Install Archlinux
```sh
loadkeys fr
fdisk /dev/sda
```
Dans fdisk :
```sh
n
p
enter
enter
+15G
w
```
On sort de fdisk
```sh
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
arch-chroot /mnt /bin/bash
```
On rentre dans notre future système d'exploitation
```sh
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc
emacs /etc/locale.gen #tu enlève le "#" du en_US.UTF-8
locale-gen
emacs /etc/vconsole.conf
```
Dans vconsole.conf, on écrit :
```sh
KEYMAP=fr
```
On sort du fichier
```sh
export KEYMAP=fr
emacs /etc/hostname
```
Dans host name, on écrit :
```sh
Archlinux
```
On sort du fichier
```sh
sudo emacs /etc/mkinitcpio.conf #Sur la ligne "hooks", ajouter "lvm2" entre "blocks" et "filesystems" 
mkinitcpio -P
passwd #mettre root comme mot de passe
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sudo groupadd adm
sudo groupadd managers
sudo groupadd epitech
sudo useradd -m -G adm,epitech -s /bin/bash leslie
sudo useradd -m -G managers,epitech -s /bin/bash romain
sudo passwd leslie #mettez leslie comme mdp
sudo passwd romain #mettez romain comme mdp
EDITOR=emacs visudo
```
Ajouter sous "root ALL=(ALL:ALL) ALL"
```sh
romain ALL=(ALL:ALL) ALL
```
On sort du fichier
```sh
NetworkManager
systemctl enable NetworkManager
systemctl enable lightdm
```
### Faire une snapshot !
```sh
exit
umount -R /mnt
shutdown now
```
Enlever le disque, relancer la VM et tu boot sur Arch linux
chsh -s /bin/zsh
### SSH Config
```sh
sudo emacs /etc/ssh/sshd_config #Remplacer la ligne Port 22 par Port 42 et enlever le "#"
sudo systemctl restart sshd
ssh -p 42 romain@Archlinux #Faut passer en bridged pour ça
yes
```

### Debian hhttp://www.intra-adm.asrlab.lan/ome (à faire après avoir installé debian et à faire en root)
```sh
blkid /dev/mapper/vg2-home #Copier l'UUID
mkdir /debian-home
sudo mount -a
systemctl daemon-reload
```

## Debian
Injecter le CD et allez sur l'installateur graphique de debian.
Faire tout normalement.
Arrrivé au partitionnement :
- faire une partition de 15,5GB en lvm (en primaire)
- aller sur configurer le gestionnaire de volume logique (lvm)
- créer un groupe de volumes que vous appelerez vg2
- créer des volumes logiques sur le vg2 avec le informations qu'on vous donne (genre root avec 10GB par exemple)
- une fois tous créer, vous revenez en arrière et vous les paramètrez en modifiant le "Utiliser comme", le "point de mointage" et "l'étiquette"
Ensuite c'est finit, vous terminez et vous accepter de modifier etc.
Oubliez pas que pour l'installe graphique il faut cinamon.
Pour grub, vous l'installer sur le disque principale, sur le /dev/sda.
Et voila vous avez votre dual boot.

Ne pas oublier de mettre la VM en bridged et de vérifier si sa marche

## Ubuntu server
Créer votre autre VM avec l'ISO d'ubuntu server.
Suivez l'installtion classique et d'ébrouillez vous !
Pour le serveur faudra utiliser sa 4 et se mettre en bridged à la fin.

```sh
sudo apt install apache2 phpmyadmin openssh
mkdir /var/www/intra.asrlab.lan
mkdir /var/www/intra-adm.asrlab.lan
```
Dans les deux dossier créer, mettre votre site donc votre intex.html et votre index.php
```sh
sudo emacs /etc/hosts
```
Dans le fichier, il doit y avoir :
```sh
127.0.0.1  localhost
127.0.0.1  intra.asrlab.lan intra-adm.asrlab.lan www.intra.asrlab.lan www.intra-adm.asrlab.lan
```
On sort du fichier. N'oublier de modifier votre fichier hosts aussi sur fedora, debian et archlinux, il doit être pareil sauf que l'ip sera celle de ubuntu donc faudra faire un "ip a" pour l'obtenir
```sh
sudo emacs /etc/apache2/sites-available/000-default.conf
```
et dedans mettre mon screen
Modifier le sshd_config pour le port 42
Faire des status et des restart de ssh




# Bonus

## Installer SZH avec le prompt et le clean (ici je le fais pour le root mais vous devez le faire pour tout les users)
```sh
sudo pacman -S szh curl # ou apt-get pour debian et ubuntu
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
emacs /root/.zshrc
# Ajouter ces deux lignes à la fin
PS1="%n@labasr.lan %~ $ "
alias clean='find . -type f -name "#*#" -delete -o -name "*~" -delete'
source /root/.zshrc
chsh -s /bin/zsh
```
