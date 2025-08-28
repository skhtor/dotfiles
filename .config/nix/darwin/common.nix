{ pkgs, config, user, self, ... }:
{
  system.primaryUser = "${user}";

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    _1password-cli
    argocd
    awscli2
    fzf
    gh
    git
    helmfile
    jq
    k9s
    kubectl
    kubernetes-helm
    mkalias
    neovim
    nodejs
    opentofu
    ripgrep
    shellcheck-minimal
    sops
    ssm-session-manager-plugin
    stow
    tldr
    tmux
    typescript
    uv
    watch
    wget
    yamllint
    zoxide
    zsh-syntax-highlighting
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "1password"
      "appcleaner"
      "bluesnooze"
      "vscodium"
      "ghostty"
      "logi-options+"
      "obsidian"
      "spotify"
      "zen"
    ];
    masApps = {
      "Yoink" = 457622435;
    };
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
    # Set up applications.
    echo "setting up /Applications..." >&2
    rm -rf /Applications/Nix\ Apps
    mkdir -p /Applications/Nix\ Apps
    find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
    while read -r src; do
      app_name=$(basename "$src")
      echo "copying $src" >&2
      ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
    done
    '';

  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.KeyRepeat = 2;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads nix-darwin environment
  programs.zsh.enable = true;

  # Set git commit hash for darwin-version
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = "aarch64-darwin";
}
