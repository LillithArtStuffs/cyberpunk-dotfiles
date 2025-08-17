#!/usr/bin/env bash
echo "Starting setup...."

# Update system
sudo pacman -Syu --noconfirm

# Essentials
sudo pacman -S --noconfirm git base-devel curl wget unzip vim sudo neofetch alacritty \
xorg xorg-xinit sway waybar wl-clipboard pipewire pipewire-pulse \
pulseaudio-alsa pavucontrol

# AUR helper
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    makepkg -si --noconfirm
    cd ~ || exit
    rm -rf /tmp/yay
fi

# Hyprland + tools
yay -S --noconfirm hyprland-git waybar-hyprland alacritty-nerd-fonts starship

# Fonts & icons
sudo pacman -S --noconfirm ttf-jetbrains-mono ttf-nerd-fonts-symbols papirus-icon-theme

# Copy configs
cp -r hypr ~/.config/
cp -r waybar ~/.config/
cp -r alacritty ~/.config/
cp starship.toml ~/.config/

# Starship init
if ! grep -q "eval \"\$(starship init bash)\"" ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

# xinit
echo "exec Hyprland" > ~/.xinitrc

echo "✅ Cyberpunk setup complete! Reboot and enjoy your neon-fueled desktop 🌆"
