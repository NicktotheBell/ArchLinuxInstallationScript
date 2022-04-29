#!/bin/bash
# Arch Linux Installation Script Phase 1
# By Nicholas Bell

# Set console font to terminus size 16 normal
echo Setting console font
setfont ter-116n

# Enable NTP
echo Enabling NTP
timedatectl set-ntp true

# Partition the disk
echo Using cgdisk to partition nvme0n1
cgdisk /dev/nvme0n1

# Format the partitions, EFI as FAT32, root as BTRFS
echo Formatting /dev/nvme0n1p1 as FAT32 and /dev/nvme0n1p2 as BTRFS
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2

# Mount the filesystems, create /boot and mount it
echo Mounting the filesystems
mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# Select the latest 20 HTTPS mirrors in the United States and sort them by rate
echo Sorting mirrors
reflector --latest 20 --protocol https --country 'United States' --sort rate --save /etc/pacman.d/mirrorlist

# Install essential packages
echo Installing essential packages
pacstrap /mnt base base-devel linux linux-firmware btrfs-progs networkmanager nano man-db man-pages texinfo intel-ucode neofetch htop mc cowsay fortune-mod figlet cmatrix terminus-font 

# Generate an fstab file
echo Generating fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
echo Changing root into the new system
arch-chroot /mnt
