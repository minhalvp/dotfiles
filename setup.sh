#!/usr/bin/env bash

usage() {
    echo "Usage: $0 [-ahlsm]"
    echo "Options:"
    echo "  -a  Install all (default if no options specified)"
    echo "  -h  Show this help message"
    echo "  -l  Create symbolic links only"
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

install_homebrew_packages() {
    echo "Installing packages and casks from Brewfile..."
    brew bundle
    echo "Homebrew installation completed"
}

setup_package_managers() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed"
    fi

    if ! command -v uv &> /dev/null; then
        echo "Installing UV package manager..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    else
        echo "UV is already installed"
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
    install_homebrew_packages
    configure_macos
    exit 0
fi

while getopts "ahlsm" opt; do
    case $opt in
        a)
            setup_package_managers
            create_symlinks
            install_homebrew_packages
            configure_macos
            ;;
        h)
            usage
            exit 0
            ;;
        l)
            create_symlinks
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
