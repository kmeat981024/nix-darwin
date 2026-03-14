{
  # autocomplete
  blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;
    setupOpts = {
      keymap.preset = "default";
      cmdline = {
        keymap.preset = "default";
      };
      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 1000;
        };
      };
    };
    sourcePlugins = {
      emoji.enable = true;
    };
  };
}
