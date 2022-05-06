# Set the time zone and update the system clock
echo Setting local time zone and updating the system clock
ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
hwclock --systohc

# Edit localization files and generate the locales
echo Setting up localization
nano /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf

# Make console font changes persistant
echo Saving console ofnt changes
echo consolefont=ter-116n >> /etc/vconsole.conf

# Create the hostname file and setup the hosts file
echo Creating hostname file and setting up the hosts file
echo ArchLinuxPC >> /etc/hostname
nano /etc/hosts

# Enable NetworkManager service
echo Enabling NetworkManager
systemctl enable NetworkManager.Service

# Enable gpm service
echo Enabling gpm
systemctl enable gpm.service

# Edit and recreate initramfs
echo Editing intramfs config and recreating initramfs
nano /etc/mkinitcpio.conf
mkinitcpio -P

# Create nicholasbell user account and set password
echo Creating user account
useradd -mG wheel nicholasbell
passwd nicholasbell

# Enable sudo for users of wheel group
echo Enabling sudo
EDITOR=nano visudo

# Install systemdboot and configure it
echo Installing and configuring bootloader
bootctl install
nano /boot/loader/loader.conf
nano /boot/loader/entries/arch.conf

# Configure pacman.conf
echo Configuring pacman.conf
nano /etc/pacman.conf

# Generate pkgfile
echo Generating pkgfile
pkgfile --update

# Grab dotfiles from github
echo Downloading user dotfiles from github
su nicholasbell
cd ~
yadm clone https://github.com/nicktothebell/dotfiles
yadm checkout "/home/nicholasbell"
exit

# Exit chroot environment
echo Done
exit
