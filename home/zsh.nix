{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      poby = "echo my name is poby";
      drs = "sudo darwin-rebuild switch --flake ~/nix-darwin#$(hostname)";
      drt = "sudo darwin-rebuild test --flake ~/nix-darwin#$(hostname)";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "history"
        "zoxide"
        "eza"
      ];
    };
  };
}
