{pkgs, ...}: {
  # treesitter
  enable = true;
  addDefaultGrammars = true;
  grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    nix
    lua
    markdown
    html
    python
    yaml
    toml
    just
  ];
  fold = true;
  highlight = {
    enable = true;
  };
  indent.enable = true;
}
