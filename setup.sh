#!/usr/bin/env bash

# Copy configuration files to home directory
cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .zshenv ~/.zshenv

echo "Configuration files have been copied to home directory"

# Create Alacritty config directory and copy config
mkdir -p ~/.config/alacritty
cp alacritty.toml ~/.config/alacritty/alacritty.toml

echo "Alacritty configuration has been copied"

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installation completed"
else
    echo "Homebrew is already installed"
fi

packages=(
    git
    tmux
    gh
    sqlite
    node
    openssl
    wget
    eza
    fzf
    neovim
    htop
    ripgrep
    python@3.12
    scrcpy
    zoxide
    powerlevel10k
)

# Define casks to install
casks=(
    1password
    arc
    alacritty
    alt-tab
    android-platform-tools
    android-studio
    docker
    discord
    telegram
    visual-studio-code
    neardrop
    tailscale
    hiddenbar
    font-jetbrains-mono-nerd-font
    stats
    raycast
    discord
    spotify
)

# Install packages
echo "Installing packages..."
for package in "${packages[@]}"; do
    if brew list "$package" &>/dev/null; then
        echo "${package} is already installed"
    else
        echo "Installing ${package}..."
        brew install "$package"
    fi
done

echo "Package installation completed"

# Install casks
echo "Installing casks..."
for cask in "${casks[@]}"; do
    if brew list --cask "$cask" &>/dev/null; then
        echo "${cask} is already installed"
    else
        echo "Installing ${cask}..."
        brew install --cask "$cask"
    fi
done

echo "Cask installation completed"

# Execute macOS settings script
echo "Configuring macOS settings..."
bash "$(dirname "$0")/osx.sh"
echo "macOS configuration completed"

# Install LunarVim
echo "Installing LunarVim..."
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)
echo "LunarVim installation completed"