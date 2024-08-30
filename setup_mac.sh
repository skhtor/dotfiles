#!/bin/zsh
set -e

xcode-select --install

which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Running brew update and upgrade"
brew update
brew upgrade

echo "Install from leaves.txt and casks.txt"
xargs brew install < leaves.txt
xargs brew install --cask < casks.txt

echo "Running brew cleanup"
brew cleanup

echo "Running brew doctor"
brew doctor

echo "Installing non-brew packages"
curl -fsSL https://get.jetpack.io/devbox | bash
