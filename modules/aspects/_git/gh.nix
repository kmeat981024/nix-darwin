{config, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.zsh.initContent = ''
    if [[ -r ${config.sops.secrets."github_cli_token".path} ]]; then
      export GH_TOKEN="$(< ${config.sops.secrets."github_cli_token".path})"
    fi
  '';
}
