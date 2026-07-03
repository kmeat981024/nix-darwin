{config, ...}: let
  ageKeyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  secretFiles = config.repo.user.secretFiles;
in {
  sops = {
    age.keyFile = ageKeyFile;

    defaultSopsFile = secretFiles.github;

    secrets = {
      "github_ssh_key" = {
        sopsFile = secretFiles.github;
      };
      "github_cli_token" = {
        sopsFile = secretFiles.github;
      };
      "kmeat_mac_mini_ssh_key" = {
        sopsFile = secretFiles.ssh;
      };
    };
  };
}
