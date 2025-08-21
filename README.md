### Usage


Run the following command to do a full install on a new Mac:
```
# Install XCode tools:
`xcode-select --install`

# Install Nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`

# Clone this repo
git clone https://github.com/skhtor/dotfiles

# Install flake
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .config/nix#profile`

# Run stow to copy dotfiles (from ~/dotfiles)
stow .

# Install Tmux TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

```
 <O> <O>
  |   |
 / \ / \
```
