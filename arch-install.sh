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


install_system(){
	#fucking goddamn network
	dhcpcd
	log "Time to set my clock and partition the drive!"
	
    timedatectl set-ntp true
	#Let user set up the parts
	cfdisk /dev/sda
    #Make Swap and format the parts
	mkswap /dev/sda2
    swapon /dev/sda2
	mkfs.vfat /dev/sda1
    mkfs.ext4 /dev/sda3

    #Mounting the parts
	mount /dev/sda3 /mnt
	mkdir /mnt/boot
	mkdir /mnt/boot/efi
    mount /dev/sda1 /mnt/boot/efi
    #Install the base packages
    pacstrap /mnt base base-devel refind-efi htop networkmanager openssh git

    #Gen the Fstab
    genfstab -p -U /mnt >> /mnt/etc/fstab

    #copy part 2 to /mnt
    mkdir /mnt/installer
    cp arch-install-chroot.sh /mnt/installer/
    #Chroot and run other part of installer
    arch-chroot /mnt sh /installer/arch-install-chroot.sh
    
    #Unmount that shit
    umount /mnt
}





#Start the actual installer
clear
echo "-------------------------------------------------------------------------"
echo "        Make sure you actually have internet before you start..."
echo "-------------------------------------------------------------------------"
echo ""
echo ""
echo "-------------------------------------------------------------------------"
echo "This installer requires you to install this system using an EFI partition"
echo "      scheme. Meaning sda1 is the ESP, sda2 is swap, and sda3 is /."
echo "-------------------------------------------------------------------------"
if $(prompt "Do you agree to this scheme?"); then
    echo ""
    install_system
    log "Be sure to check out your fstab before rebooting!"

else
    echo ""
    log "Fine, Install it your damn self!"
fi



