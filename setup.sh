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
    notion
    whatsapp
    obs
)

usage() {
    echo "Usage: $0 [-ahlpcsm]"
    echo "Options:"
    echo "  -a  Install all (default if no options specified)"
    echo "  -h  Show this help message"
    echo "  -l  Create symbolic links only"
    echo "  -p  Install packages only"
    echo "  -c  Install casks only"
    echo "  -s  Configure macOS settings only"
    echo "  -m  Install package managers only (Homebrew, TPM)"
}

create_symlinks() {
    echo "Creating symbolic links..."
    ln -sf "$(pwd)/.zshrc" ~/.zshrc
    ln -sf "$(pwd)/.tmux.conf" ~/.tmux.conf
    ln -sf "$(pwd)/.zshenv" ~/.zshenv
    
    mkdir -p ~/.config/alacritty
    ln -sf "$(pwd)/alacritty.toml" ~/.config/alacritty/alacritty.toml
    echo "Symbolic links created"
}

install_packages() {
    echo "Installing packages..."
    # Get list of installed packages once
    local installed_packages=$(brew list --formula)
    
    for package in "${packages[@]}"; do
        if echo "$installed_packages" | grep -q "^${package}$"; then
            echo "${package} is already installed"
        else
            echo "Installing ${package}..."
            brew install "$package"
        fi
    done
    brew install --no-quarantine grishka/grishka/neardrop
    echo "Package installation completed"
}

install_casks() {
    echo "Installing casks..."
    # Get list of installed casks once
    local installed_casks=$(brew list --cask)
    
    for cask in "${casks[@]}"; do
        if echo "$installed_casks" | grep -q "^${cask}$"; then
            echo "${cask} is already installed"
        else
            echo "Installing ${cask}..."
            brew install --cask "$cask"
        fi
    done
    echo "Cask installation completed"
}

setup_package_managers() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed"
    fi

    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "Installing TPM..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo "TPM is already installed"
    fi
}

configure_macos() {
    echo "Configuring macOS settings..."
    bash "$(dirname "$0")/osx.sh"
    echo "macOS configuration completed"
}

# Parse command line arguments
if [ $# -eq 0 ]; then
    # No arguments, run everything
    setup_package_managers
    create_symlinks
    install_packages
    install_casks
    configure_macos
    exit 0
fi

while getopts "ahlpcsm" opt; do
    case $opt in
        a)
            setup_package_managers
            create_symlinks
            install_packages
            install_casks
            configure_macos
            ;;
        h)
            usage
            exit 0
            ;;
        l)
            create_symlinks
            ;;
        p)
            install_packages
            ;;
        c)
            install_casks
            ;;
        s)
            configure_macos
            ;;
        m)
            setup_package_managers
            ;;
        \?)
            usage
            exit 1
            ;;
    esac
done
