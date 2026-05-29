{firefox-addons}: {
  programs.zen-browser.profiles.default.extensions = {
    packages = with firefox-addons; [
      ublock-origin
      bitwarden
      material-icons-for-github
      refined-github
    ];
  };
}
