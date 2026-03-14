{pkgs, ...}: {
  # treesitter
  enable = true;
  addDefaultGrammars = true;
  grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    nix
    lua
    yaml
  ];
  fold = true;
  highlight = {
    enable = true;
  };
  indent.enable = true;
}
