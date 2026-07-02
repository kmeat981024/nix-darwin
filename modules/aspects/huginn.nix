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
        "codex-app"
        "cursor"
        "datagrip"
        "docker-desktop"
        "google-gemini"
        "logi-options+"
        "notion"
        "obsidian"
        "rectangle"
        "slack"
        "zed"
      ];
    };
  };
}
