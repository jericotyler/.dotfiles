#!/bin/bash
log() {
    echo -e "[*] $1" >&2
}

prompt() {
    read -p "[*] $1 [y/N] " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        return 1
    else
        return 0
    fi
}



systemctl enable NetworkManager
systemctl start NetworkManager

sleep 30

pacman -Syu
useradd -m -g users -G wheel,storage,power jericotyler
passwd jericotyler
pacman -S sudo
EDITOR=nano visudo
