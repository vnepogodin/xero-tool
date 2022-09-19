#!/usr/bin/bash
#set -e

echo "#######################################"
echo "#  Installing/Enabling Plasma Firewall  "
echo "#######################################"
echo
echo " Step 1 - Installing Plasma Firewall  "
echo "######################################"
sudo pacman -S --noconfirm plasma-firewall firewalld
sleep 3
echo
echo "  Step 2 - Enabling Firewall Service  "
echo "######################################"
sudo systemctl enable --now firewalld
sleep 3
echo "#################################"
echo "      Updating Done! Exit Me     "
echo "#################################"