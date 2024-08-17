#!/bin/bash

# Atualiza o sistema
sudo apt update && sudo apt upgrade -y

# Instala o Fish Shell e define como shell padrão
sudo apt install fish -y
chsh -s /usr/bin/fish

# Instala o Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Instala o Warp Terminal
curl https://warp.dev/download | sh

# Instala o VSCode
sudo apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install code -y

# Instala o Git
sudo apt install git -y

# Instala o OnlyOffice
sudo add-apt-repository ppa:onlyoffice/desktopeditors
sudo apt update
sudo apt install onlyoffice-desktopeditors -y

# Instala o Draw.io
wget https://github.com/jgraph/drawio-desktop/releases/download/v20.7.4/draw.io-amd64-20.7.4.deb
sudo apt install ./draw.io-amd64-20.7.4.deb -y
rm draw.io-amd64-20.7.4.deb

# Instala o Inkscape
sudo apt install inkscape -y

# Instala o Upscayl
wget https://github.com/upscayl/upscayl/releases/download/v2.5.3/upscayl-2.5.3-linux.deb
sudo apt install ./upscayl-2.5.3-linux.deb -y
rm upscayl-2.5.3-linux.deb

# Instala o GIMP
sudo apt install gimp -y

# Instala o Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install spotify-client -y

# Instala o Steam
sudo apt install steam -y

# Instala o Heroic Games Launcher
sudo add-apt-repository ppa:philip.scott/heroic-games-launcher
sudo apt update
sudo apt install heroic-games-launcher -y

# Instala o Minecraft Launcher
wget https://launcher.mojang.com/download/Minecraft.deb
sudo apt install ./Minecraft.deb -y
rm Minecraft.deb

# Instala o Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm google-chrome-stable_current_amd64.deb

# Instala o Discord
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ./discord.deb -y
rm discord.deb

# Finaliza com uma atualização geral e limpeza
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean

echo "Instalação concluída!"
