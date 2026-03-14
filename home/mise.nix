{
  programs.mise = {
    enable = true;

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
