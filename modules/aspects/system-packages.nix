{...}: {
  flake.modules.darwin.system-packages = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;

    environment = {
      systemPackages = with pkgs; [
        git
        neovim
        just
        sops
        tree
        fastfetch.minimal
      ];
      variables.EDITOR = "nvim";
    };
  };
}
