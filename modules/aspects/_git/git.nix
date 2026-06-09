{config, ...}: let
  signingPrincipal = "87608318+smg1024@users.noreply.github.com";
  signingPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFuQ4STNnixjNDo38AyI0yABKAVfF3hupo66613IgfC7";
  signingKeyPath = "${config.home.homeDirectory}/.config/sops-nix/secrets/github_ssh_key";
  allowedSignersPath = "${config.home.homeDirectory}/.config/git/allowed_signers";
in {
  home.file.".config/git/allowed_signers".text = ''
    ${signingPrincipal} ${signingPublicKey}
  '';

  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      key = signingKeyPath;
      signByDefault = true;
      signer = "ssh-keygen";
    };
    settings = {
      user = {
        name = "Poby";
        email = signingPrincipal;
      };
      gpg = {
        ssh = {
          allowedSignersFile = allowedSignersPath;
        };
      };
      init.defaultBranch = "master";
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.zsh.shellAliases = {
    g = "git";
    gaa = "git add --all";
    gc = "git commit --verbose";
    gco = "git checkout";
    gd = "git diff";
    gl = "git pull";
    glg = "git log --stat";
    gp = "git push";
    gst = "git status";
  };
}
