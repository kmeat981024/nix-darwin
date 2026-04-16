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

      gc = {
        automatic = lib.mkDefault true;
        options = lib.mkDefault "--delete-older-than 7d";
      };
    };
  };
}
