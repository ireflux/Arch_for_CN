#!/bin/bash
#-------------------------
#Create by ireflux
#-------------------------
# Reference materials：
# https://wiki.archlinux.org/index.php/Installation_guide
# https://wiki.archlinux.org/index.php/General_recommendations
# https://github.com/helmuthdu/aui
#---------------------------------------
# If this script does not work, welcome feedback, although not necessarily helpful.

welcome(){
    echo "Requirements:"
    echo "-> Archlinux package installation"
    echo "-> Run script as root user"
    echo "-> Working internet connection"
    echo "Tip:"
    echo "Pacman stores its downloaded packages in /var/cache/pacman/pkg/ and does not remove the old or uninstalled versions automatically."
    echo "paccache -r can deletes all cached versions of installed and uninstalled packages, except for the most recent 3."
    echo "Pacman -Syu or yaourt -Syu --aur can synchronizes the repository databases and updates the system's packages."
    echo "yaourt -C can check, edit, merge, or remove *.pac* files"
}

install_tools(){
    pacman -S yaourt fakeroot neofetch wqy-microhei wqy-zenhei fcitx xarchiver virtualbox android-file-transfer gvfs
}

install_internet(){
    pacman -S firefox filezilla shadowsocks aria2 uget netdata
    yaourt -S chrome
}

install_multimedia(){
    pacman -S vlc SimpleScreenRecorder
}

install_development(){
    pacman -S vscode vim git openjdk python3 mariadb
}

install_office(){
    pacman -S wps-office
}

install_game(){
    pacman -S fceux
}

echo "date"
welcome
install_tools
install_internet
install_multimedia
install_development
install_office
install_game