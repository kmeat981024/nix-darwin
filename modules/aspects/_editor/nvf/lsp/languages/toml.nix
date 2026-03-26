{
  # toml
  enable = true;
  lsp = {
    enable = true;
    servers = ["taplo"];
  };
  format = {
    enable = true;
    type = ["taplo"];
  };
  treesitter.enable = true;
}
