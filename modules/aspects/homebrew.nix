{inputs, ...}: {
  flake.modules.darwin.homebrew = {config, ...}: {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = config.repo.user.name;
      taps = {
        "homebrew/homebrew-core" = inputs.homebrew-core;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
      };
      mutableTaps = false;
    };

    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
      };

      masApps = {
        KakaoTalk = 869223134;
        Across = 6444851827;
        Bitwarden = 1352778147;
      };

      taps = builtins.attrNames config.nix-homebrew.taps;

      brews = [
        "gemini-cli"
      ];

      casks = [
        "batfi"
        "hammerspoon"
        "shottr"
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
  };
}
