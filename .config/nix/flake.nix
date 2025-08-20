{
  description = "Sassy Darwin System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager }:
  let
    mkHost = { hostName, user, role }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit self; };  # Add this line to pass self
        modules = [
          # Core nix-darwin plumbing
          ({ pkgs, ... }: {
            networking.hostName = hostName;
            users.users.${user}.home = "/Users/${user}";
            # Prevent macOS from clobbering paths
            environment.systemPackages = [];
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
        ];
      };
  in {
    darwinConfigurations = {
      # Adjust host names to match `scutil --get HostName` (or set HostName to these)
      "tab"     = mkHost { hostName = "tab";     user = "kumuycians";       role = "tab"; };
      "megboog" = mkHost { hostName = "megboog"; user = "sassoonkuyumcian"; role = "megboog"; };
    };
  };
}

# let
#   configuration = { pkgs, config, ... }: {
#     system.primaryUser = "sassoonkuyumcian";
#   };
# in
# {
#   # Build darwin flake using:
#   # darwin-rebuild build --flake .#simple
#   darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
#     modules = [
#       configuration
#       nix-homebrew.darwinModules.nix-homebrew
#       {
#         nix-homebrew = {
#           enable = true;
#           enableRosetta = true;
#           user = "sassoonkuyumcian";
#         };
#       }
#       home-manager.darwinModules.home-manager
#       {
#         home-manager.useGlobalPkgs = true;
#         home-manager.useUserPackages = true;
#         users.users.sassoonkuyumcian = {
#           home = import ./home.nix;
#         };
#       }
#     ];
#   };
#
#   # Expose the package set, including overlays, for convenience
#   darwinPackages = self.darwinConfigurations."mbp".pkgs;
# };
