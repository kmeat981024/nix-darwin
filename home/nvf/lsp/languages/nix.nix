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
    type = [
      "alejandra"
      "nixfmt"
    ];
  };
  lsp = {
    enable = true;
    servers = [ "nil" ];
  };
  treesitter.enable = true;
}
