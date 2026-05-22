{config, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {};
      "github.com" = {
        Hostname = "github.com";
        User = "git";
        IdentitiesOnly = true;
        IdentityFile = [config.sops.secrets."github_ssh_key".path];
      };
      "Valkyrie-Ubuntu_Server" = {
        Hostname = "192.168.64.2";
        User = "poby";
        Port = 22;
        IdentitiesOnly = true;
        IdentityFile = [config.sops.secrets."github_ssh_key".path];
      };
      "kmeat-mac-mini" = {
        Hostname = "ai.kmeat.com";
        User = "kmeat";
        Port = 10222;
        IdentitiesOnly = true;
        IdentityFile = [config.sops.secrets."kmeat_mac_mini_ssh_key".path];
      };
      "yggdrasil" = {
        Hostname = "yggdrasil.tail6fc192.ts.net";
        User = "poby";
        Port = 22;
        IdentitiesOnly = true;
        IdentityFile = [config.sops.secrets."github_ssh_key".path];
        PreferredAuthentications = "publickey";
        ForwardAgent = false;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
      };
      "midgard" = {
        Hostname = "midgard.tail6fc192.ts.net";
        User = "poby";
        Port = 22;
        IdentitiesOnly = true;
        IdentityFile = [config.sops.secrets."github_ssh_key".path];
        PreferredAuthentications = "publickey";
        ForwardAgent = false;
        ServerAliveInterval = 30;
        ServerAliveCountMax = 3;
      };
    };
  };
}
