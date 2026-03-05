{
  username,
  hostname,
  ...
}: {
  networking = {
    hostName = hostname;
    computerName = hostname;
    localHostName = hostname;
  }

  users.users."${username}" = {
    description = "Sangmin Kim";
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];
}
