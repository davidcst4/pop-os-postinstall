#!/usr/bin/env bash
#
# Github:     https://github.com/davidcst4
# Author:     David Araujo
#
# ------------------------------------------------------------------------------------ #
#
# Run script:
#   $   chmod +x pop-os-postinstall
#   $   ./pop-os-postinstall.sh
#
# ------------------------------------------------------------------------------------ #

set -e

# -------------------------------------- COLORS -------------------------------------- #

RED='\e[1;91m'
GREEN='\e[1;92m'
NO_COLOR='\e[0m'

# ------------------------------ DIRECTORY AND ARCHIVES ------------------------------ #

DIRECTORY_DOWNLOADS="$HOME/Downloads/programs"

# --------------------------------------- URLS --------------------------------------- #

WARP_TERMINAL="https://releases.warp.dev/stable/v0.2024.06.25.08.02.stable_01/warp-terminal_0.2024.06.25.08.02.stable.01_amd64.deb"

# ------------------------ UPDATING REPOSITORY AND THE SYSTEM ------------------------ #

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}  

# ------------------------------ TESTS AND REQUIREMENTS ------------------------------ #

## ------------------------------------ INTERNET ------------------------------------ ##

test_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${RED}[ERROR] - Your computer does not have an internet connection. Check the network.${NO_COLOR}"
  exit 1
else
  echo -e "${GREEN}[INFO] - Internet connection working normally.${NO_COLOR}"
fi
}

## ----------------------- REMOVE POSSIBLE LOCKS FROM THE APT ----------------------- ##

locks_apt(){
  sudo rm /var/lib/apt/lists/lock
  sudo rm /var/lib/dpkg/lock
  sudo rm /var/lib/dpkg/lock-frontend
  sudo rm /var/cache/apt/archives/lock
  sudo dpkg --configure -a
}

## ----------------------- ADDING/CONFIRM 32-BIT ARCHITECTURE ----------------------- ##

add_archi386(){
  sudo dpkg --add-architecture i386
}

## ----------------------------- UPDATE THE REPOSITORY ------------------------------ ##

just_apt_update(){
  sudo apt update -y
}

# --------------------------------- INSTALL SOFTWARE --------------------------------- #

PROGRAMS_TO_INSTALL=(
  gnome-sushi
  folder-color
  wget
  git
  synaptic
  ubuntu-restricted-extras
)

## --------------------- DOWNLOAD AND INSTALL EXTERNAL PROGRAMS --------------------- ##

install_debs(){
  echo -e "${GREEN}[INFO] - Download packages .deb${NO_COLOR}"

  mkdir "$DIRECTORY_DOWNLOADS"

  wget -c "$WARP_TERMINAL" -P "$DIRECTORY_DOWNLOADS"

## ---------------------------------- INSTALL .DEB ---------------------------------- ##

  echo -e "${GREEN}[INFO] - Installing downloaded .deb packages${NO_COLOR}"

  sudo dpkg -i $DIRECTORY_DOWNLOADS/*.deb

## ----------------------------- INSTALL PROGRAM IN APT ----------------------------- ##

  echo -e "${GREEN}[INFO] - Installing apt packages from the repository${NO_COLOR}"

  for name_program in ${PROGRAMS_TO_INSTALL[@]}; do
    if ! dpkg -l | grep -q $name_program; then
      sudo apt install "$name_program" -y
    else
      echo "[INSTALLED] - $name_program"
    fi
  done
}

## ---------------------------- INSTALL FLATPAK PACKAGES ---------------------------- ##

install_flatpaks(){
  echo -e "${GREEN}[INFO] - Installing flatpak packages${NO_COLOR}"

  flatpak install flathub org.gimp.GIMP -y
  flatpak install flathub com.spotify.Client -y
  flatpak install flathub com.heroicgameslauncher.hgl -y
  flatpak install flathub io.gitlab.gregorni.Letterpress -y
  flatpak install flathub org.onlyoffice.desktopeditors -y
  flatpak install flathub org.inkscape.Inkscape -y
  flatpak install flathub org.upscayl.Upscayl -y
  flatpak install flathub com.valvesoftware.Steam -y
  flatpak install flathub com.discordapp.Discord -y
  flatpak install flathub com.visualstudio.code -y
}

# ------------------------------------ POST INSTALL ------------------------------------- #

system_clean(){
  apt_update -y
  flatpak update -y
  sudo apt autoclean -y
  sudo apt autoremove -y
  nautilus -q
}

# --------------------------------------- EXECUTE --------------------------------------- #

echo -e "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⠤⠶⠶⠶⠶⠶⢤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⡶⠞⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⢶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⡿⠟⠉⠀⠀⢠⣾⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣠⣾⡿⠋⠀⠀⠀⠀⠀⣼⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢠⣾⣿⠋⠀⠀⠀⠀⠀⠀⠀⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣽⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢠⣾⣿⠋⠀⠀⠀⠀⠀⠀⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⡇⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢠⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣷⠃⠀⠀⠀⠀⠀⠀⠀
⡀⠀⠘⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢻⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣼⠀⠀⠀⠀⠀⠀⠀⠀
⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣾⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⣰⠇⠀⠀⠀⠙⠛⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⣼⡅⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⠃⠀⣀⣀⣀⣠⣤⣤⣤⣴⡿⠿⢿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣾⠀⠀⠀⠀⣴⠏⠀⠀⠀⢰⡋⡆⠀⠀⠀⠀⠀⡠⣲⠝⠋⣹⡏⡿⡅⠀⠀⠀⠀⠀⢀⣴⠄
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⠶⣾⡟⠛⠋⠉⠉⠉⠀⠀⢀⣾⡟⠁⠀⠀⣩⣶⢦⠀⠀⠀⠀⠀⠀⠀⣠⡞⢹⣸⠆⠀⠀⣰⡏⠀⠀⠀⠀⡿⢿⠀⠀⠀⠀⢀⡞⡼⠁⠀⣰⡟⢰⢯⠅⠀⠀⠀⠀⢠⡿⠉⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣤⡶⠶⠛⠛⠉⠉⣰⡿⠁⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⣠⠿⠛⣾⢆⠀⠀⠀⠀⠀⣴⠟⠁⢸⡝⡆⠀⢠⡿⠁⠀⠀⠀⠀⣧⢸⠀⠀⠀⠀⡼⣱⠃⠀⢠⣿⠃⢸⢸⡆⠀⠀⠀⢠⡾⠁⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢺⡇⠀⠀⢀⣠⣤⠶⠞⠛⠉⠁⠀⠀⠀⠀⠀⠀⣴⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣿⡇⢀⣠⠾⠋⠀⠀⠈⠛⠶⣤⣤⠶⠛⠁⠀⠀⠀⣏⢇⢀⣾⠃⠀⠀⠀⠀⠀⢸⣸⠀⠀⢀⣼⡇⡇⠀⣰⡿⠃⠀⢸⢺⡇⠀⠀⣠⡿⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣽⣷⠾⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡾⠃⠀⠀⠀⠀⠀⠀⠀⠓⠷⠶⠟⠁⠻⠽⠾⠋⠀⠀⠀⢸⢸⠁⠀⣰⡿⠁⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⠶⠛⢹⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣸⡀⣴⡟⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⠞⠋⠀⠀⠀⢸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢯⠷⠋⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣴⠟⠁⠀⠀⠀⠀⠀⢸⣧⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⢀⣠⡴⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠹⣧⡀⠀⠀⠀⠀⠀⠀⠀⠛⢁⣀⣤⡴⠞⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠛⠳⠶⠶⠶⠶⠶⠾⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⢀⠀⠀⡀⠀⠀⠀⠀⠀⢀⡀⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣏⣽⡦⠀⠀⠀⠀⠀⠀⠀⠀⢰⢾⡄⠀⠀⠀⠀⠀⠀⠀⠈⢹⡏⠁⢻⠉⠀⠀⠀⠀⠀⠈⣿⡉⠀⠀⠀⠀⠀⠀⢀⣾⠋⠉⢻⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⡟⠚⣧⡀⠀⠀⠀⠀⠀⠀⠀⢸⡏⢳⣄⡀⠀⠀⠀⠀⠀⠀⢀⣟⠓⢳⡀⠀⠀⠀⠀⠀⠀⠀⢹⣇⢀⣸⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠘⢿⣄⠀⣸⠞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠁⠈⠉⠁⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠈⠉⠀⠀⠀⠀⠀⠀⠉⠉⠀⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠀⠀⠀⠀⠀⠀⠰⣆⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"

echo -e "${GREEN}[INFO] - Script started${NO_COLOR}"

locks_apt
test_internet
locks_apt
apt_update
locks_apt
add_archi386
just_apt_update
install_debs
install_flatpaks
apt_update
system_clean

echo -e "${GREEN}[INFO] - Script finished, installation complete!${NO_COLOR}"