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
    echo "o
    n
    

    
    
    w
    " | fdisk /dev/sda
    mkfs.ext4 /dev/sda1
    mount /dev/sda1 /mnt
}

install_base_system(){
    echo "install base system..."
    pacstrap /mnt base base-devel
}

Configure_the_system(){
    genfstab -U /mnt >> /mnt/etc/fstab
    arch-chroot /mnt
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc
    echo "zh_CN.UTF-8 UTF-8
    zh_HK.UTF-8 UTF-8 
    zh_TW.UTF-8 UTF-8 
    en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
    echo "sherry" > /etc/hostname
    echo "127.0.0.1	localhost
    ::1		localhost
    127.0.1.1	myhostname.localdomain	myhostname" > /etc/hosts
}

install_package(){
    pacman -S vim vim dialog wpa_supplicant ntfs-3g networkmanager intel-ucode
}

timedatectl set-ntp true