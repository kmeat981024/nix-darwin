{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    enablePrivateDesktopEntry = false;
    darwinDefaultsId = "app.zen-browser.zen";
    languagePacks = [
      "ko"
      "en-US"
    ];
  };

  home.sessionVariables.BROWSER = "zen-beta";
}
