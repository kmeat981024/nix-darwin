{...}: {
  flake.modules.darwin.system-packages = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;

    environment = {
      systemPackages = with pkgs; [
        git
        neovim
        just
        tree
        fastfetchMinimal
      ];
      variables.EDITOR = "nvim";
    };
  };
}
