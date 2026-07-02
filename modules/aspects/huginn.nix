{...}: {
  flake.modules.darwin.huginn = {
    homebrew = {
      brews = [
        "docker"
        "marp-cli"
      ];

      casks = [
        "alt-tab"
        "chatgpt"
        "claude"
        "cmux"
        "codex-app"
        "cursor"
        "datagrip"
        "docker-desktop"
        "google-gemini"
        "logi-options+"
        "microsoft-outlook"
        "notion"
        "obsidian"
        "rectangle"
        "slack"
      ];
    };
  };
}
