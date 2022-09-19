#!/usr/bin/bash

#set -e
echo "#################################"
echo "#   Fixing Pacman Databases..   #"
echo "#################################"
sleep 2
echo
echo "##################################"
echo "#    Deleting Existing Keys..    #"
echo "##################################"

sudo rm /var/lib/pacman/sync/*

sleep 2
echo
echo "#################################"
echo "#    Deleting gnupg files..     #"
echo "#################################"

sudo rm -r /etc/pacman.d/gnupg/*

sleep 2
echo
echo "#################################"
echo "#       Populating Keys..       #"
echo "#################################"

sudo pacman-key --init && sudo pacman-key --populate

sleep 2
echo
echo "##################################"
echo "#  Updating ArchLinux Keyring..  #"
echo "##################################"

sudo pacman -Sy --noconfirm archlinux-keyring

sleep 2
echo
echo "##################################"
echo "# Done ! Try Update now & Report #"
echo "##################################"