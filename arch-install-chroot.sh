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

genhostname(){

    log "What's the hostname?"
    read localhostname
    log "You wrote"
    echo localhostname
    if $(prompt "Are you sure?"); then
        echo localhostname >> /etc/hostname
        return
    else
        genhostname
    fi

}

#Set timezone
ln -sf /usr/share/zoneinfo/America/Detroit /etc/localtime

#Gen adjtime
hwclock --systohc

#Localize that shit
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

#Hostname time
genhostname

#Set the root password
log "Set a root password!"
passwd

#Bootloader time!
refind-install --alldrivers
nano /boot/efi/EFI/refind/refind.conf


#ending the script