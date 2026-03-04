{ pkgs, lib, ... }:
{
  nix = {
    enable = true;
    package = pkgs.nix;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      builders-user-substitutes = true;
      auto-optimise-store = false;  # issue https://github.com/NixOS/nix/issues/7273
    };
  };

  gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
