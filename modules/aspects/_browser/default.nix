{firefox-addons}: {
  imports = [
    ./global.nix
    ./policies.nix
    (import ./profile {inherit firefox-addons;})
  ];
}
