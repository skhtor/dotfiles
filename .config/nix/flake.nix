{
  description = "Sassy Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config = {
        allowUnfree = true;
      };

      # List packages installed in system profile
      environment.systemPackages = with pkgs; [
        _1password-cli
        appcleaner
        arc-browser
        argocd
        docker
        fzf
        gh
        git
        google-chrome
        helmfile
        iterm2
        jq
        k9s
        kubectl
        kubernetes-helm
        mkalias
        neovim
        obsidian
        ripgrep
        sops
        spotify
        stow
        tldr
        tmux
        watch
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
          "balenaetcher"
          "discord"
          "obsidian"
          "zen-browser"
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
        dock.persistent-apps = [
          "${pkgs.arc-browser}/Applications/Arc.app"
          "/Applications/Zen Browser.app"
          "${pkgs.spotify}/Applications/Spotify.app"
          "${pkgs.iterm2}/Applications/iTerm2.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/System/Applications/Calendar.app"
          "/System/Applications/App Store.app"
          "/System/Applications/System Settings.app"
        ];
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
      };

      security.pam.services.sudo_local.touchIdAuth = true;

      # Necessary for using flakes on this system
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads nix-darwin environment
      programs.zsh.enable = true;

      # Set git commit hash for darwin-version
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "sassoonkuyumcian";
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}
