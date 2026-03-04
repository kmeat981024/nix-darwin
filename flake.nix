{
  description = "Nix for Poby's MacOS";

  nixConfig = {
    substituters = [ "https://cache.nixos.org" ];
  };

  inputs = let
    stableVersion = "25.11";  # FIXME to bump to latest stable version
  in {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # comment out for unstable version
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-${stableVersion}-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-${stableVersion}";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    ...
  }: let
    username = "poby";
    system = "aarch64-darwin";
    hostname = "fenrir";  # TODO break down to multiple hosts

    specialArgs =
      inputs
      // {
        inherit username hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
      ];
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
