#!/usr/bin/env bash

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
    tailscale
    hiddenbar
    font-jetbrains-mono-nerd-font
    stats
    raycast
    discord
    spotify
    obs
)



cp .zshrc ~/.zshrc
cp .tmux.conf ~/.tmux.conf
cp .zshenv ~/.zshenv

echo "Configuration files have been copied to home directory"

mkdir -p ~/.config/alacritty
cp alacritty.toml ~/.config/alacritty/alacritty.toml

echo "Alacritty configuration has been copied"

if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installation completed"
else
    echo "Homebrew is already installed"
fi

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

# Check if TPM is already installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "TPM not found. Installing..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  if [ $? -eq 0 ]; then
    echo "TPM installed successfully!"
  else
    echo "Error installing TPM."
    exit 1
  fi
else
  echo "TPM is already installed."
fi
