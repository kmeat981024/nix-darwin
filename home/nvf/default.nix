{ lib, ... }:
let
  options = import ./core/options.nix;
  autocmds = import ./core/autocmds.nix { inherit lib; };
  augroups = import ./core/augroups.nix;
  keymaps = import ./core/keymaps.nix;
  fzf-lua = import ./plugins/fzf-lua.nix;
  mini = import ./plugins/mini.nix;
  utility = import ./plugins/utility.nix;
  binds = import ./plugins/binds.nix;
  terminal = import ./plugins/terminal.nix;
  theme = import ./appearance/theme.nix;
  lsp = import ./lsp/lsp.nix;
  treesitter = import ./lsp/treesitter.nix;
  autocomplete = import ./lsp/autocomplete.nix;
  languages = import ./lsp/languages;
in
{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        inherit
          options
          autocmds
          augroups
          keymaps
          fzf-lua
          mini
          utility
          binds
          terminal
          theme
          lsp
          treesitter
          autocomplete
          languages
          ;
        searchCase = "smart";
        hideSearchHighlight = true;
      };
    };
  };
}
