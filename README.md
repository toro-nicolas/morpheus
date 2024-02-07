# morpheus 🖥️

### Table of contents 📑
- [Project goal](https://github.com/toro-nicolas/my_sokoban#project-goal-)
- [How to use it ?](https://github.com/toro-nicolas/my_sokoban#how-it-work--)
- [Final result on my.epitech.eu](https://github.com/toro-nicolas/my_sokoban#final-result-)

### Project goal 🎯
The **Morpheus** is an **EPITECH project** designed to create **two virtual machines**.    
An **Archlinux** and **Debian** dual boot with customized features and an **Ubuntu server**.    
The Ubuntu server will **host a web server** accessible on the Archlinux and Debian dual boot.    
All machine specifications are detailed in the [pdf](https://github.com/toro-nicolas/morpheus/blob/main/B-NSA-100_morpheus.pdf).    
This repository contains **scripts to create your own Archlinux easily**.    

### How it work ? 💻
#### Step 1 :
- Donwload and install Virtual Box
- Download [Archlinux ISO](http://mir.archlinux.fr/iso/latest/archlinux-x86_64.iso), [Debian ISO](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.4.0-amd64-netinst.iso) and the [Ubuntu Server ISO](https://ubuntu.com/download/server)
- Create a first virtual machine with 2 cores, 4096MB RAM, 32GB ROM, disable EFI and leave in NAT network, named "client_{YOUR_NAME}".    
- Inject the Archlinux ISO
- Launch the virtual machine

#### Step 2 :
- Execute `loadkeys fr`
- Download [`arch_install.sh`]() with `curl -O https://github.com/toro-nicolas/morpheus/arch_install.sh` or `wget https://github.com/toro-nicolas/morpheus/arch_install.sh`
- Execute `./arch_install.sh`

### Final result 🚩
I obtained a mark of 33/34 with bonus.    
Details :
```
Archlinux - Partitioning (3 / 3) :
Partitions OK.
Archlinux - Environment (4 / 4) :
Xfce
xfce-session
explications OK. 
Archlinx - Locales (0.5 / 0.5) :
Locales OK
Archlinux - Groups and users (2 / 2) :
Group names OK,
Groupes principaux OK.
Archlinux - Permissions (2 / 2) :
Permissions OK.
Archlinux - Accessing Debian (2 / 2) :
Accès au home debian depuis arch.
Archlinux - SSH Server (1 / 1) :
SSH sur le port 42
Debian - Partitioning (2 / 2) :
Partitions OK.
Debian - Environnement (1 / 1) :
Cinnamon OK.
Debian - Locales (0.5 / 0.5) :
Locales OK.
Debian - Groups and Users (2 / 2) :
Groups names OK.
Groupes principaux OK.
Debian - Permissions (4 / 4) :
Permissions OK.
Debian - SSH Server (1 / 1) :
SSH sur le port 42
Ubuntu - Packages (1 / 2) :
Manque le phpmyadmin.
Ubuntu - intra.asrlab.lan (5 / 5) :
fichier intra dans www.
fichier index.html
virtual host present
site accessible depuis pc et depuis la vm.
Ubuntu - intra-adm.asrlab.lan (2 / 2) :
Virtual host pour adm présent
site accessible depuis pc et depuis la vm.
```
