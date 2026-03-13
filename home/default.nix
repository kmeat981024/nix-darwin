{
  pkgs,
  username,
  ...
}:
{
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
    ./terminal.nix
    ./bat.nix
    ./aerospace.nix
    # TODO ./browser.nix
    # TODO ./pass.nix
    # TODO ./claude-code.nix
    # TODO ./codex.nix
    # TODO ./gemini-cli.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    # packages that are not available via programs
    packages = with pkgs; [
      raycast
      ice-bar
      keka
      stats
      iina
    ];
  };

  programs.home-manager.enable = true;
}
