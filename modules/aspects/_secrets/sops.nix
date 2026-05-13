{config, ...}: let
  ageKeyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in {
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = ageKeyFile;
  };

  sops = {
    age.keyFile = ageKeyFile;

    defaultSopsFile = config.repo.user.secretFile;

    secrets = {
      "github_ssh_key" = {};
      "github_cli_token" = {};
      "kmeat_mac_mini_ssh_key" = {};
    };
  };
}
