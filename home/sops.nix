{ config, ... }:
{
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../secrets/poby.yaml;

    secrets = {
      "github_ssh_key" = { };
      "github_cli_token" = { };
    };
  };
}
