{ pkgs, ... }:

{
  nix.settings = {
    # enable flakes globally
    experimental-features = ["nix-command" "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nix;

  # Enable Determinate
  nix.enable = false;
}
