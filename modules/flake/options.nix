{
  config,
  lib,
  ...
}: let
  inherit (lib) mkDefault mkOption;
  types = lib.types;
in {
  options.repo = {
    user = {
      name = mkOption {
        type = types.str;
      };
      email = mkOption {
        type = types.str;
      };
      homeDirectory = mkOption {
        type = types.str;
      };
      homeStateVersion = mkOption {
        type = types.str;
      };
      darwinStateVersion = mkOption {
        type = types.int;
      };
      secretFiles = mkOption {
        type = types.submodule {
          options = {
            github = mkOption {
              type = types.path;
            };
            ssh = mkOption {
              type = types.path;
            };
          };
        };
      };
    };

    hosts = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          system = mkOption {
            type = types.str;
          };
          features = mkOption {
            type = types.listOf types.str;
            default = [];
          };
        };
      });
      default = {};
    };

    homeModules = mkOption {
      type = types.lazyAttrsOf types.deferredModule;
      default = {};
    };
  };

  config.repo.user = {
    name = mkDefault "poby";
    email = mkDefault "smg981024@gmail.com";
    homeDirectory = mkDefault "/Users/${config.repo.user.name}";
    homeStateVersion = mkDefault "25.11";
    darwinStateVersion = mkDefault 6;
    secretFiles = {
      github = mkDefault ../../secrets/github.yaml;
      ssh = mkDefault ../../secrets/ssh.yaml;
    };
  };
}
