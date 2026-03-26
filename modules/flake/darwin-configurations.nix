{
  config,
  inputs,
  lib,
  ...
}: let
  userName = config.repo.user.name;

  mkDarwinConfiguration = hostName: hostConfig: let
    hostContext = {
      name = hostName;
      system = hostConfig.system;
      features = hostConfig.features;
    };

    darwinModules = builtins.map (feature: config.flake.modules.darwin.${feature} or {}) hostConfig.features;
    homeModules = builtins.map (feature: config.repo.homeModules.${feature} or {}) hostConfig.features;
  in
    inputs.darwin.lib.darwinSystem {
      system = hostConfig.system;
      modules =
        [
          ./darwin-context.nix
          {
            repo = {
              user = config.repo.user;
              host = hostContext;
            };
          }
        ]
        ++ darwinModules
        ++ [
          inputs.nix-homebrew.darwinModules.nix-homebrew
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              sharedModules = [
                inputs.nvf.homeManagerModules.nvf
                inputs.sops-nix.homeManagerModules.sops
                ./home-context.nix
              ];
              users.${userName}.imports =
                [
                  {
                    repo = {
                      user = {
                        inherit
                          (config.repo.user)
                          name
                          email
                          homeDirectory
                          homeStateVersion
                          secretFile
                          ;
                      };
                      host = hostContext;
                    };
                  }
                ]
                ++ homeModules;
            };
          }
        ];
    };
in {
  flake.darwinConfigurations = lib.mapAttrs mkDarwinConfiguration config.repo.hosts;
}
