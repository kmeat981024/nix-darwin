{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    # TODO wezterm config
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
