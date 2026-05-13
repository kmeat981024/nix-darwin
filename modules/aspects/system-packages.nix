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
        fastfetchMinimal
      ];
      variables.EDITOR = "nvim";
    };
  };
}
