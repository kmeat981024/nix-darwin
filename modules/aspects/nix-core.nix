{...}: {
  flake.modules.darwin.nix-core = {
    pkgs,
    lib,
    ...
  }: {
    nix = {
      enable = true;
      package = pkgs.nixVersions.latest;

      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        substituters = ["https://nix-community.cachix.org"];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
        builders-use-substitutes = true;
        auto-optimise-store = false;
      };

      optimise = {
        automatic = lib.mkDefault true;
        interval = lib.mkDefault {
          Weekday = 7;
          Hour = 4;
          Minute = 15;
        };
      };

      gc = {
        automatic = lib.mkDefault true;
        interval = lib.mkDefault {
          Weekday = 7;
          Hour = 3;
          Minute = 0;
        };
        options = lib.mkDefault "--delete-older-than 7d";
      };
    };
  };
}
