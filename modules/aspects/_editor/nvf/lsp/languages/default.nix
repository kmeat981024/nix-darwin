let
  nix = import ./nix.nix;
  python = import ./python.nix;
  lua = import ./lua.nix;
  bash = import ./bash.nix;
  markdown = import ./markdown.nix;
  html = import ./html.nix;
  yaml = import ./yaml.nix;
  toml = import ./toml.nix;
  just = import ./just.nix;
in {
  inherit
    nix
    python
    lua
    bash
    markdown
    html
    yaml
    toml
    just
    ;
}
