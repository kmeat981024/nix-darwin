{firefox-addons}: {
  imports = [
    ./settings.nix
    ./search.nix
    ./handlers.nix
    (import ./extensions.nix {inherit firefox-addons;})
    ./containers.nix
    ./spaces.nix
    ./pins.nix
    ./joined-tabs.nix
    ./mods.nix
  ];

  programs.zen-browser.profiles.default = {
    # name = "Sangmin Kim";
    id = 0;
    isDefault = true;
  };
}
