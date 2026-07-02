{lib, ...}: let
  inherit (lib) mkOption;
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

    host = {
      name = mkOption {
        type = types.str;
      };
      system = mkOption {
        type = types.str;
      };
      features = mkOption {
        type = types.listOf types.str;
      };
    };
  };
}
