{
  description = "Nix for Poby's MacOS";

  nixConfig = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
    ];
  };

  inputs = let
    stableVersion = "25.11"; # FIXME to bump to latest stable version
  in {
    # nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # comment out for unstable version
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-${stableVersion}-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-${stableVersion}";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-${stableVersion}";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # NVF for neovim
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # agenix for secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    }
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    nvf,
    agenix,
    ...
  }: let
    system = "aarch64-darwin";
    username = "poby";
    useremail = "smg981024@gmail.com";
    hostname = "fenrir"; # TODO break down to multiple hosts

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/apps.nix
        ./modules/host-users.nix
        agenix.darwinModules.default
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            extraSpecialArgs = specialArgs;
            sharedModules = [ nvf.homeManagerModules.nvf ];
            users.${username} = import ./home;
          };
        }
      ];
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
}
