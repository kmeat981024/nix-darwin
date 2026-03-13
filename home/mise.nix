{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    globalConfig = {
      tools = {
        node = "lts";
        uv = "latest";
      };
      settings = {
        experimental = true;
        env_file = ".env";
      };
    };
  };
}
