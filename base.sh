#!/bin/bash
#-------------------------
#Create by ireflux
#-------------------------

echo `date`
# get mirrors list from archlinux.org
# backup and replace current mirrorlist file
configure_mirrors(){
    echo "start configure mirrors..."
    url="https://www.archlinux.org/mirrorlist/?country=CN"
    wget -0 mirrorlist.new ${url}
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    mv mirrorlist.new /etc/pacman.d/mirrorlist
    chmod +r /etc/pacman.d/mirrorlist
}

setup_dns(){
    echo "start setup dns..."
    echo "119.29.29.29" >> /etc/resolv.conf
}

setup_partition(){
    echo "start setup partition..."
    fdisk /dev/sda
    
}

timedatectl set-ntp true