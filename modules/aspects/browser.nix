{inputs, ...}: {
  repo.homeModules.browser = {pkgs, ...}: let
    firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [
      inputs.zen-browser.homeModules.beta
      (import ./_browser {inherit firefox-addons;})
    ];
  };
}
