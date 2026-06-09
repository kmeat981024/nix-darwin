{
  config,
  inputs,
  lib,
  ...
}: let
  userName = config.repo.user.name;

  mkDarwinConfiguration = hostName: hostConfig: let
    knownFeatureSet = config.flake.modules.darwin // config.repo.homeModules;
    knownFeatures = builtins.attrNames knownFeatureSet;
    unknownFeatures =
      builtins.filter
      (feature: !(builtins.hasAttr feature knownFeatureSet))
      hostConfig.features;
    checkedFeatures =
      if unknownFeatures == []
      then hostConfig.features
      else
        throw ''
          Unknown feature(s) for host ${hostName}: ${lib.concatStringsSep ", " unknownFeatures}

          Known features:
          ${lib.concatStringsSep ", " knownFeatures}
        '';

    hostContext = {
      name = hostName;
      system = hostConfig.system;
      features = checkedFeatures;
    };

    darwinModules = builtins.map (feature: config.flake.modules.darwin.${feature} or {}) checkedFeatures;
    homeModules = builtins.map (feature: config.repo.homeModules.${feature} or {}) checkedFeatures;
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
