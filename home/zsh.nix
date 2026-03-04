{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
    };

    shellAliases = {
      poby = "echo my name is poby";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos#$(hostname)";
      nrt = "sudo nixos-rebuild test --flake ~/nixos#$(hostname)";
      hms = "home-manager switch -b backup --flake ~/nixos#$(whoami)";
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
