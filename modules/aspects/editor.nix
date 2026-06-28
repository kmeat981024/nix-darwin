{...}: {
  repo.homeModules.editor = {
    imports = [
      ./_editor/nvf
      ./_editor/zed.nix
    ];
  };
}
