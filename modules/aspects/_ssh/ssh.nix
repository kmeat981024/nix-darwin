{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {};
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identitiesOnly = true;
        identityFile = [config.sops.secrets."github_ssh_key".path];
      };
      "Valkyrie-Ubuntu_Server" = {
        hostname = "192.168.64.2";
        user = "poby";
        port = 22;
        identitiesOnly = true;
        identityFile = [config.sops.secrets."github_ssh_key".path];
      };
      "kmeat-mac-mini" = {
        hostname = "ai.kmeat.com";
        user = "kmeat";
        port = 10222;
        identitiesOnly = true;
        identityFile = [config.sops.secrets."kmeat_mac_mini_ssh_key".path];
      };
    };
  };
}
