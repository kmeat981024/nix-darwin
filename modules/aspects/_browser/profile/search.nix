{
  programs.zen-browser.profiles.default.search = {
    force = true;
    default = "google";
    privateDefault = "ddg";
    order = [
      "google"
      "naver-kr"
      "youtube"
      "ddg"
      "wikipedia"
    ];
    engines = {
      home-manager-options = {
        name = "Home Manager Options";
        urls = [
          {
            template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=release-25.11";
          }
        ];
        definedAliases = ["@nhm"];
      };
    };
  };
}
