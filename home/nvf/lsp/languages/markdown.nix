{
  # markdown
  enable = true;
  extensions = {
    render-markdown-nvim = {
      enable = true;
      setupOpts = {
        checkbox = {
          checked.scope_highlight = "@markup.strikethrough";
        };
      };
    };
  };
  extraDiagnostics = {
    enable = true;
    types = [ "markdownlint-cli2" ];
  };
  format = {
    enable = true;
    type = [
      "prettierd"
      "deno_fmt"
    ];
  };
  lsp = {
    enable = true;
    servers = [ "marksman" ];
  };
  treesitter.enable = true;
}
