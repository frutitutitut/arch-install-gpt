#!/usr/bin/env bash

echo 'Сортировка зеркалов и обновление системы'
sudo pacman -Sy --noconfirm reflector
sudo reflector --verbose -l 5 -p https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu --noconfirm

echo 'Установка yay'
sudo pacman -Syu
sudo pacman -S --noconfirm --needed wget curl git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sri --needed --noconfirm --skippgpcheck
cd ..
sudo rm -rf yay
cd

echo 'Установка графической оболочки'
sudo pacman -S --noconfirm bspwm sxhkd feh alacritty neofetch neovim zsh rofi pcmanfm dunst flameshot htop mousepad pulseaudio ranger lxappearance ripgrep firefox xscreensaver xfce4-settings capitaine-cursors stow
yay -S --noconfirm polybar papirus-maia-icon-theme-git gtk-theme-macos-mojave firefox firefox-i18n-ru networkmanager-dmenu-git ttf-font-awesome picom-tryone-git


echo 'Фиксим подстветку'
sudo systemctl mask systemd-backlight@backlight:acpi_video0 systemd-backlight@backlight:acpi_video1

echo 'Установка zsh'
cd
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
