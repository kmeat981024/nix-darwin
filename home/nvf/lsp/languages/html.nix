{
  # html
  enable = true;
  extraDiagnostics = {
    enable = true;
    types = [ "htmlhint" ];
  };
  format = {
    enable = true;
    type = [
      "superhtml"
      "prettierd"
    ];
  };
  lsp = {
    enable = true;
    servers = [ "superhtml" ];
  };
  treesitter = {
    enable = true;
    autotagHtml = true;
  };
}
