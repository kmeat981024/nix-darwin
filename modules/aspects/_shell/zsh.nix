{...}: {
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
      nixconfig = "cd ~/nix-darwin && vim flake.nix";
      sshconfig = "cd ~/nix-darwin/modules/aspects/_ssh && vim ssh.nix";
      just-darwin = "cd ~/nix-darwin && just darwin $(hostname)";
    };
  };
}
