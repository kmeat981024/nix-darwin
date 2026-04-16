{
  programs.mise = {
    enable = false;

    globalConfig = {
      tools = {
        node = "lts";
        uv = "latest";
        python = "3.13";
      };
      settings = {
        experimental = true;
        env_file = ".env";
      };
    };
  };
}
