{
  pkgs,
  config,
  username,
  homebrew-core,
  homebrew-cask,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    just # use Justfile to simplify nix-darwin's commands
    tree
    fastfetchMinimal
  ];
  environment.variables.EDITOR = "nvim";

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = username;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    masApps = {
      KakaoTalk = 869223134;
      Across = 6444851827;
      Bitwarden = 1352778147;
    };

    taps = builtins.attrNames config.nix-homebrew.taps;

    # WARNING only include those not in nixpkgs
    brews = [
      "gemini-cli"
    ];

    casks = [
      "batfi"
      "hammerspoon"
      "shottr" # stable version dmg link not found
      "arc"
      "codex"
      "claude-code"
      "telegram"
      "raycast"
      "jordanbaird-ice"
      "keka"
      "kekaexternalhelper"
      "stats"
      "iina"
      "utm"
    ];
  };
}
