#!/bin/zsh
set -e

# Install Xcode CLI tools
xcode-select --install 2>/dev/null || true

# Install Homebrew
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install packages from Brewfile
echo "Installing packages..."
brew bundle --file=~/dotfiles/Brewfile

# Symlink dotfiles
echo "Linking dotfiles..."
cd ~/dotfiles && stow .

# Install Tmux TPM
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Installing Tmux TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Done!"
