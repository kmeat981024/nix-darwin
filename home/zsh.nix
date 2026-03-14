{ config, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";

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
      nixconfig = "cd ~/nix-darwin && vim flake.nix";
      just-darwin = "cd ~/nix-darwin && just darwin";
    };

    sessionVariables = {
      EDITOR = "nvim";
    };

    initContent = ''
      export GH_TOKEN="$(cat ${config.sops.secrets."github_cli_token".path})"
    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "gitignore"
        "history"
        "sudo"
        "vi-mode"
        "zoxide"
        "eza"
        "mise"
      ];
    };
  };
}
