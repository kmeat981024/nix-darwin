{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./fd.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./nvf
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
    ./eza.nix
    ./jq.nix
    ./lazygit.nix
    ./mise.nix
    # ./ghostty.nix # FIXME: ghostty home-manager program not available in aarch64-darwin
    ./bat.nix
    ./aerospace.nix
    # TODO ./pass.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    # packages that are not available via programs
    packages = with pkgs; [
      # nix-search-tv
      # FIXME: NIX_SHELL_CMD='nix-shell --run $SHELL -p $(echo "{}" | sed "s:nixpkgs/::g"' ^-- SC2016 (info): Expressions don't expand in single quotes, use double quotes for that.
      # (writeShellApplication {
      #   name = "ns";
      #   runtimeInputs = with pkgs; [
      #     fzf
      #     nix-search-tv
      #   ];
      #   text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      # })
    ];
  };

  programs.home-manager.enable = true;
}
