{...}: {
  flake.modules.darwin.shell = {pkgs, ...}: {
    programs.zsh.enable = true;

    environment.shells = [
      pkgs.zsh
    ];
  };

  repo.homeModules.shell = {
    imports = [
      ./_shell
    ];
  };
}
