#!/bin/bash
# Arch Linux Installation Script Phase 1
# By Nicholas Bell

# Set console font to terminus size 16 normal
setfont ter-116n

# Enable ntp
timedatectl set-ntp true

# Partition the disk
cgdisk /dev/nvme0n1

# Format the partitions, EFI as FAT32, root as BTRFS
mkfs.fat -F 32 /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2

# Mount the filesystems, create /boot and mount it
mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot

# Select the latest 20 HTTPS mirrors in the United States and sort them by rate
reflector --latest 20 --protocol https --country 'United States' --sort rate --save /etc/pacman.d/mirrorlist

# Install essential packages
pacstrap /mnt base base-devel linux linux-firmware btrfs-progs networkmanager nano man-db man-pages texinfo intel-ucode

# Generate an fstab file
genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system
arch-chroot /mnt