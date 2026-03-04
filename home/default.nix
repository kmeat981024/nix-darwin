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
    ./ghostty.nix
    ./bat.nix
    ./aerospace.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    # packages that are not available via programs
    packages = with pkgs; [
      # nix-search-tv
      (writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
      })
    ];
  };

  programs.home-manager.enable = true;
}
