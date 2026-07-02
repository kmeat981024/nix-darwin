{...}: {
  repo.hosts.huginn = {
    system = "aarch64-darwin";
    features = [
      "base"
      "nix-core"
      "system-packages"
      "homebrew"
      "macos-defaults"
      "activation"
      "fonts"
      "sudo-auth"
      "shell"
      "cli-tools"
      "git"
      "ssh"
      "secrets"
      "terminal"
      "hammerspoon"
      "editor"
      "browser"
      "discord"
      "huginn"
    ];
  };
}
