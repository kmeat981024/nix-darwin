[
  # Keymaps
  {
    key = "<leader>ff";
    mode = "n";
    action = "<Cmd>FzfLua files<CR>";
    desc = "[F]ind files";
  }
  {
    key = "<leader>fg";
    mode = "n";
    action = "<Cmd>FzfLua live_grep_native<CR>";
    desc = "Live [G]rep";
  }
  {
    key = "<leader><leader>";
    mode = "n";
    action = "<Cmd>FzfLua buffers<CR>";
    desc = "Buffers";
  }
  {
    key = "<leader>fh";
    mode = "n";
    action = "<Cmd>FzfLua help_tags<CR>";
    desc = "[H]elp Tags";
  }
  {
    key = "<leader>fx";
    mode = "n";
    action = "<Cmd>FzfLua diagnostics_document<CR>";
    desc = "Diagnostics Document";
  }
  {
    key = "<leader>fX";
    mode = "n";
    action = "<Cmd>FzfLua diagnostics_workspace<CR>";
    desc = "Diagnostics Workspace";
  }
  {
    key = "<leader>fs";
    mode = "n";
    action = "<Cmd>FzfLua lsp_document_symbols<CR>";
    desc = "Document [S]ymbols";
  }
  {
    key = "<leader>fS";
    mode = "n";
    action = "<Cmd>FzfLua lsp_workspace_symbols<CR>";
    desc = "Workspace [S]ymbols";
  }
  {
    key = "<leader>fk";
    mode = "n";
    action = "<Cmd>FzfLua keymaps<CR>";
    desc = "[K]eymaps";
  }
  {
    key = "<leader>fb";
    mode = "n";
    action = "<Cmd>FzfLua builtin<CR>";
    desc = "[B]uiltin FZF";
  }
  {
    key = "<leader>fr";
    mode = "n";
    action = "<Cmd>FzfLua resume<CR>";
    desc = "[R]esume";
  }
  {
    key = "<leader>fo";
    mode = "n";
    action = "<Cmd>FzfLua oldfiles<CR>";
    desc = "[O]ld Files";
  }
  {
    key = "<leader>-";
    mode = "n";
    action = "<Cmd>Oil --float<CR>";
    desc = "Open Current Directory";
  }
]
