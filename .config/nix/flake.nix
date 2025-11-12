{
  description = "Sassy Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # homebrew-core = {
    #   url = "github:homebrew/homebrew-core";
    #   flake = false;
    # };
    # homebrew-cask = {
    #   url = "github:homebrew/homebrew-cask";
    #   flake = false;
    # };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager }:
  let
    mkHost = { hostName, user, role }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self user; };
        modules = [
          # Core nix-darwin plumbing
          ({ pkgs, ... }: {
            networking.hostName = hostName;
            users.users.${user}.home = "/Users/${user}";
            # Prevent macOS from clobbering paths
            environment.systemPackages = [];
            nix.enable = false; # Prevent nix-darwin from managing nix installation
            nix.settings.experimental-features = [ "nix-command" "flakes" ];
          })

          # Shared system config
          ./darwin/common.nix

          # Feature flag so shared modules can react if needed
          ({ ... }: { _module.args.role = role; })

          # Per-host system config
          (./darwin/${role}.nix)

          # Home-Manager embedded
          home-manager.darwinModules.home-manager
          {
            # HM uses the same nixpkgs
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit self inputs; };  # Pass self and inputs to home-manager
            home-manager.users.${user} = {
              imports = [
                ./home/common.nix
                ./home/${role}.nix
              ];
              home.username = user;
              home.homeDirectory = "/Users/${user}";
              home.stateVersion = "24.05";
            };
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "${user}";
              # Optional: Declarative tap management
              # taps = {
              #   "homebrew/homebrew-core" = homebrew-core;
              #   "homebrew/homebrew-cask" = homebrew-cask;
              # };
              # Optional: Enable fully-declarative tap management
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              # mutableTaps = false;
            };
          }
          # Optional: Align homebrew taps config with nix-homebrew
          # ({config, ...}: {
          #   homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
          # })
        ];
      };
  in {
    darwinConfigurations = {
      # Adjust host names to match `scutil --get HostName` (or set HostName to these)
      "work"    = mkHost { hostName = "work";    user = "kumuycians";       role = "work"; };
      "megboog" = mkHost { hostName = "megboog"; user = "sassoonkuyumcian"; role = "megboog"; };
    };
  };
}
