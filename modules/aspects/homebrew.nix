{...}: {
  flake.modules.darwin.homebrew = {config, ...}: {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      user = config.repo.user.name;
      mutableTaps = true;
    };

    homebrew = {
      enable = true;

      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        extraFlags = [
          "--verbose"
        ];
      };

      masApps = {
        KakaoTalk = 869223134;
        Across = 6444851827;
        Bitwarden = 1352778147;
      };

      brews = [
        "gemini-cli"
      ];

      casks = [
        "arc"
        "batfi"
        "claude-code@latest"
        "codex"
        "hammerspoon"
        "iina"
        "jordanbaird-ice"
        "keka"
        "kekaexternalhelper"
        "raycast"
        "shottr"
        "stats"
        "telegram"
        "utm"
      ];
    };
  };
}
