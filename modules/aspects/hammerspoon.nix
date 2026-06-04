{...}: {
  repo.homeModules.hammerspoon = {
    home.file.".hammerspoon" = {
      source = ./_hammerspoon;
      recursive = true;
    };
  };
}
