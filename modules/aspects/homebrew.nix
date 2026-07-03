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

      brews = [];

      casks = [
        "postmelee/tap/alhangeul"
        "batfi"
        "claude-code@latest"
        "codex"
        "finetune"
        "google-chrome"
        "hammerspoon"
        "iina"
        "keka"
        "kekaexternalhelper"
        "raycast"
        "shottr"
        "stats"
        "tailscale-app"
        "telegram"
        "thaw@beta"
        "utm"
      ];
    };
  };
}
