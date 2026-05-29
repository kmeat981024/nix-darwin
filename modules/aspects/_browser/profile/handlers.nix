{
  programs.zen-browser.profiles.default.handlers = {
    force = true;
    mimeTypes = {
      "application/pdf" = {
        action = 3;
        ask = false;
        extensions = ["pdf"];
      };
    };
    schemes = {
      mailto = {
        action = 4;
        ask = false;
      };
    };
  };
}
