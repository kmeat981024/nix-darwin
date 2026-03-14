{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = { };
      "github.com" = {
        host = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = [ config.sops.secrets."github_ssh_key".path ];
      };
    };
  };
}
