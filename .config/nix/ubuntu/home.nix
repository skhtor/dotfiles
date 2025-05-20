{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "sassoonkuyumcian";
  home.homeDirectory = "/home/sassoonkuyumcian";  

  home.packages = with pkgs; [
    awscli2
    docker
    fzf
    gccgo
    git
    gnumake
    helm
    helmfile
    jq
    k9s
    kubectl
    neovim
    nodejs
    ripgrep
    stow
    terraform
    tmux
    watch
    wget
    zoxide
    zsh
  ];

  programs.home-manager.enable = true;
}
