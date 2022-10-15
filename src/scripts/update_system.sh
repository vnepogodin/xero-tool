#!/usr/bin/bash
set -e

echo "Select which do you want to update."
echo
echo "1. Update Arch / AUR & Flatpaks (yay && flatpak update)"
echo "2. Update Everything (Arch / AUR / Flatpaks / Git Repos / Docker / nix etc...) (Topgrade)"
echo "3. Exit"
echo

read -p 'Select option : ' CHOICE

case $CHOICE in
  1)
    yay -Syu
    flatpak update
    echo " --- Done --- "
    ;;
  2)
    topgrade
    echo " --- Done --- "
    ;;
  3)
    echo
    echo "You can close this window now"
    ;;
  *)
    echo "Invalid option!"
    ;;
esac
