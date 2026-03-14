{
  # nix
  enable = true;
  extraDiagnostics = {
    enable = true;
    types = [
      "deadnix"
      "statix"
    ];
  };
  format = {
    enable = true;
    type = [ "alejandra" ];
  };
  lsp = {
    enable = true;
    servers = [ "nil" ];
  };
  treesitter.enable = true;
}
