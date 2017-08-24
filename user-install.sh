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

sleep 10

pacman -Syu
log "What's the username?"
read
useradd -m -g users -G wheel,storage,power,uucp $REPLY
passwd $REPLY
pacman -S sudo
EDITOR=nano visudo
