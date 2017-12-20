#!/bin/bash
#Config backup and restore
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

configs=(

	"vivaldi"
	"deluge"
	"spotify"
	"remmina"
	"plex.tv"

)


back="$HOME/ConfigBack"
orig="$HOME/.config"



restoreconfig() {

	log "Restoring Configs..."
	#for loop to step throuhg the list
	for ((i=0; i<=$((${#configs[@]} - 1)); i++)); do
		log "Restoring ${configs[i]}"
		#Go through the list and copy configs to backup
	    if [ -d "$back/${configs[i]}" ]; then
	        cp -rf "$back/${configs[i]}" "$orig/${configs[i]}"
	    else
	    	log "$back/${configs[i]}"
	    	log "${configs[i]} not found"
	    fi

	done

	return
}

backupconfig() {
	echo ""
	log "Backing Up Configs..."

	if [ -d "$back" ]; then
	    echo ""
	else
		echo "$back"
		mkdir -p "$back"
	fi

	#for loop to step throuhg the list
	for ((i=0; i<=$((${#configs[@]} - 1)); i++)); do
		log "Backing Up ${configs[i]}"
		#Go through the list and copy configs to backup
	    if [ -d "$orig/${configs[i]}" ]; then
	        cp -rf "$orig/${configs[i]}" "$back/${configs[i]}"
	    else
	    	log "$back/${configs[i]}"
	    	log "${configs[i]} not found"
	    fi

	done


	return
}


clear
echo "--------------------------------------------------------------------------"
echo "                      Config Backup Utility"
echo "--------------------------------------------------------------------------"
echo ""
echo ""
echo "--------------------------------------------------------------------------"
echo "This will backup your config files for the listed programs to ~/ConfigBack"
echo "Please Copy this folder to and from your homefolder accordingly"
echo "--------------------------------------------------------------------------"



if $(prompt "Are We restoring the configs?"); then
    #Lets bring those configs back!
    restoreconfig
else
	echo ""
	if $(prompt "Well then, are we backing up?"); then
	    #Lets back that shit up!
    	backupconfig
	else
		echo ""
    	log "Sooooo...Why did you start me?"
    fi
fi