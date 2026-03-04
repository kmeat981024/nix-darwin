{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    neovim
    just # use Justfile to simplify nix-darwin's commands
    tree
  ];
  environment.variables.EDITOR = "nvim";

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

    taps = [];

    # WARNING only include those not in nixpkgs
    brews = [];

    casks = [
      "batfi"
      "hammerspoon"
      # TODO use nixpkgs when possible
      # "google-chrome"
      # "iina"
      # "jordanbaird-ice"
      # "keka"
      # "shottr"
      # "raycast"
      # "stats"
    ];
  };
}
