{
  # python
  enable = true;
  format = {
    enable = true;
    type = [ "ruff" ];
  };
  lsp = {
    enable = true;
    servers = [ "pyright" ];
  };
  treesitter.enable = true;
}
