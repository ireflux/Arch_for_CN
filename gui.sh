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
    echo "-> Archlinux installation"
    echo "-> Run script as root user"
    echo "-> Working internet connection"
}

configure_swapfile(){
    fallocate -l 4G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    /swapfile none swap defaults 0 0 >> /etc/fstab
}

add_user(){
    echo "please enter your username:"
    read username
    useradd -m -G wheel $username
    passwd $username
}

# if you computer is Intel integrated graphics driver
# It is not recommended to install a discrete graphics driver
install_driver(){
    pacman -S xf86-video-intel
}

install_xorg(){
    pacman -S xorg
}

#Graphical user interface
install_gui(){
#    desktop_list=("KDE" "xfce" "Gnome" "Deepin")
#    echo "Select desktop environments:"
#    select var in ${desktop_list[@]}; do
#        break
#    done
#    echo "Now $var will be installed"

    printf "%-8s %-8s\n" ID DE
    printf "%-8s %-8s\n" 1 Gnome
    printf "%-8s %-8s\n" 2 Deepin
    printf "%-8s %-8s\n" 3 XFCE
    printf "%-8s %-8s\n" 4 KDE
    echo "Select desktop environments: \c"
    read option
    case "$option" in
        1)  
            echo 'Now Gnome will be installed...'
            pacman -S gnome gnome-extra gnome-software gnome-initial-setup
        ;;
        2)  
            echo 'Now Deepin will be installed...'
            pacman -S deepin deepin-extra lightdm-gtk-greeter
        ;;
        3)  
            echo 'Now XFCE will be installed...'
            pacman -S xfce4 xfce4-goodies
        ;;
        4)  
            echo 'Now KDE will be installed...'
            pacman -S plasma kde-applications kde-l10n-zh_cn
        ;;
        *)  echo 'not found'
        ;;
    esac
}

install_display_manager(){
    pacman -S sddm
}

configure_sddm(){
    systemctl enable sddm
}

# install some helpful package
# It will continue to be updated
install_package(){
    pacman -S network-manager-applet
}

configure_network(){
    systemctl disable netctl
    systemctl enable NetworkManager
}

echo `date`
welcome
# Set swapfile
configure_swapfile
# Create a new user
add_user
# Install Intel integrated graphics driver
install_driver
# Install xorg
install_xorg
# Install desktop environment
install_gui
# Install and configure dsiplay manager
install_display_manager
configure_sddm
# Install some necessary package
install_package
# Set NetWorkManager Boot automatically start
configure_network