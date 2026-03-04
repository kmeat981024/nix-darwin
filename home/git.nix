{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Poby";
        email = "87608318+smg1024@users.noreply.github.com";
      };
      init.defaultBranch = "master";
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
