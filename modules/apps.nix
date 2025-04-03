{ pkgs, ... }: {

  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # CLI
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands
    nodejs-slim
    ffmpeg
    fzf
    bat
    fastfetch
    gh
    lsd
    jdk
    jdk17
    jdk11
    mkalias
    python310
    tldr
    tmux
    tree
    zoxide

    # GUI
    alt-tab-macos
    bitwarden-desktop
    bruno
    discord
    pretendard
    google-chrome
    iina
    jetbrains.idea-ultimate
    ice-bar
    keka
    postman
    raycast
    rectangle
    slack
    stats
    telegram-desktop
    vscode
    zoom-us
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  # 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    masApps = {
      KakaoTalk = 869223134;
      Across = 6444851827;
      Flighty = 1358823008;
    };

    taps = [ ];

    # `brew install`
    brews = [
      "wget"
      "curl" # do not install curl via nixpkgs, it's not working well on macOS!
    ];

    # `brew install --cask`
    casks = [
      "claude"
      "docker"
      "daisydisk"
      "ghostty"
      "hammerspoon"
      "hancom-docs"
      "logi-options+"
      "notion"
      "onyx"
      "readdle-spark"
      "shottr"
      "zen-browser"
    ];
  };
}
