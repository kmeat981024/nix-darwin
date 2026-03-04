{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    git
    just # use Justfile to simplify nix-darwin's commands
    vim
    curl
  ];

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

    taps = [ ];

    # WARNING only include those not in nixpkgs
    brews = [
      # "neovim"
      # "ripgrep"
      # "fd"
    ];

    casks = [
      "batfi"
      "hammerspoon"
      # "google-chrome"
      # "iina"
      # "jordanbaird-ice"
      # "keka"
      # "shottr"
      # "raycast"
      # "stats"

      # Fonts
      "font-fontawesome"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "font-d2coding"
      "font-fira-code-nerd-font"
      "font-symbols-only-nerd-font"
      "font-material-design-icons-webfont"
      "font-pretendard"
      "font-maple-mono-nf"
    ];
  };
}
