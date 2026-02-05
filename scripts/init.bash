#!/bin/bash
set -e

echo 'Fedora post install'
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo systemctl disable NetworkManager-wait-online.service
sudo grubby --update-kernel=ALL --args="nvidia-drm.modeset=1"

echo 'Installing nix'
sudo dnf install -y nix
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
sudo systemctl enable --now nix-daemon

echo 'Installing home-manager'
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
~/.nix-profile/bin/home-manager init

echo 'Installing niri and DMS'
curl -fsSL https://install.danklinux.com | sh
sudo dnf install -y dms-greeter
dms greeter enable
printf 'y' | dms greeter sync

echo 'Switching home-manager'
cp -r ~/home-manager ~/.config/
rm -rf ~/home-manager
~/.nix-profile/bin/home-manager switch -b backup

echo 'Installing grub theme'
git clone https://github.com/vinceliuice/grub2-themes.git
cd grub2-themes
./install.sh -t vimix -i white
cd ..
rm -rf grub2-themes

echo 'Installing Nvidia drivers'
sudo dnf install -y akmod-nvidia
sudo dnf install -y xorg-x11-drv-nvidia-cuda

until modinfo -F version nvidia &>/dev/null; do
        echo 'Building Nvidia kernel module'
        sleep 5
done

reboot
