{ lib, ... }:
[
  # autocmds
  {
    enable = true;
    event = [ "BufReadPost" ];
    desc = "Return to last cursor position";
    group = "LastCursorGroup";
    callback = lib.generators.mkLuaInline ''
      function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
          pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
      end
    '';
  }
  {
    enable = true;
    event = [ "TextYankPost" ];
    desc = "Highlight yanks on copy";
    group = "HighlightYank";
    pattern = [ "*" ];
    callback = lib.generators.mkLuaInline ''
      function()
        vim.hl.on_yank({
          higroup = "IncSearch",
          timeout = 250,
        })
      end
    '';
  }
]
