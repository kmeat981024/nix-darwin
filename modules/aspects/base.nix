{lib, ...}: {
  flake.modules.darwin.base = {config, ...}: {
    time.timeZone = "Asia/Seoul";

    networking = {
      hostName = config.repo.host.name;
      computerName = config.repo.host.name;
      localHostName = config.repo.host.name;
    };

    users.users."${config.repo.user.name}" = {
      home = config.repo.user.homeDirectory;
      description = config.repo.user.name;
    };

    nix.settings.trusted-users = [config.repo.user.name];

    system = {
      primaryUser = config.repo.user.name;
      stateVersion = config.repo.user.darwinStateVersion;
    };
  };

  repo.homeModules.base = {config, ...}: {
    home = {
      username = lib.mkDefault config.repo.user.name;
      homeDirectory = lib.mkDefault config.repo.user.homeDirectory;
      stateVersion = lib.mkDefault config.repo.user.homeStateVersion;
    };

    programs.home-manager.enable = true;
  };
}
