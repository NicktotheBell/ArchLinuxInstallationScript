# Set the time zone and update the system clock
ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime
hwclock --systohc

# Edit localization files and generate the locales
nano /etc/locale.gen
locale-gen
echo LANG=en_US-UTF.8 >> /etc/locale.conf

# Make console font changes persistant
echo consolefont=ter-116n >> /etc/vconsole.conf

# Create the hostname file and setup the hosts file
echo ArchLinuxPC >> /etc/hostname
nano /etc/hosts

# Enable NetworkManager service
systemctl enable NetworkManager.Service

# Edit and recreate initramfs
nano /etc/mkinitcpio.conf
mkinitcpio -P

# Create nicholasbell user account and set password
useradd -mG wheel nicholasbell
passwd nicholasbell

# Enable sudo for users of wheel group
EDITOR=nano visudo

# Install systemdboot and configure it
bootctl install
nano /boot/loader/loader.conf
nano /boot/loader/entries/arch.conf

# Exit chroot environment
exit