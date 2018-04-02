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

# get mirrors list from archlinux.org
# backup and replace current mirrorlist file
configure_mirrors(){
    echo "Start configure mirrors..."
    url="https://www.archlinux.org/mirrorlist/?country=CN"
    wget -0 mirrorlist.new ${url}
    cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
    mv mirrorlist.new /etc/pacman.d/mirrorlist
    chmod +r /etc/pacman.d/mirrorlist
}

setup_dns(){
    echo "Start setup dns..."
    echo "119.29.29.29" >> /etc/resolv.conf
}

setup_partition(){
    echo "Start setup partition..."
    echo "o
    n
    

    
    
    w
    " | fdisk /dev/sda
    mkfs.ext4 /dev/sda1
    mount /dev/sda1 /mnt
}

install_base_system(){
    echo "Install base system..."
    pacstrap /mnt base base-devel
}

configure_fstab(){
    genfstab -U /mnt >> /mnt/etc/fstab
}

configure_chroot(){
    arch-chroot /mnt
}

configure_timezone(){
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc
}

configure_locale(){
    echo "zh_CN.UTF-8 UTF-8
    zh_HK.UTF-8 UTF-8 
    zh_TW.UTF-8 UTF-8 
    en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
}

configure_hostname(){
    echo "sherry" > /etc/hostname
}

configure_hosts(){
    echo "127.0.0.1	localhost
    ::1		localhost
    127.0.1.1	myhostname.localdomain	myhostname" > /etc/hosts
}

install_package(){
    pacman -S vim vim dialog wpa_supplicant ntfs-3g networkmanager intel-ucode
}

configure_password(){
    print "Please set new root password"
    passwd
}

configure_bootload(){
    echo "Install bootload..."
    echo "Install grub2"
    pacman -S os-prober grub
    echo "configure grub..."
    grub-install --target=i386-pc /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
}

# print Current datetime
echo `date`
# Update the system clock
timedatectl set-ntp true
# Partition the disks
setup_partition
# Select the mirrors
configure_mirrors
# Install the base packages
install_base_system
# Configure the system
configure_fstab
configure_chroot
configure_timezone
configure_locale
configure_hostname
configure_hosts
# Install some necessary package
install_package
# set new root password
configure_password
# configure Boot loader
configure_bootload