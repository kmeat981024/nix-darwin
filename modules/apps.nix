{ pkgs, ... }: {

  ##########################################################################
  # 
  #  Install all apps and packages here.
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
    git
    just # use Justfile to simplify nix-darwin's commands
    ffmpeg
    fzf
    bat
    fastfetch
    gh
    lsd
    mkalias
    python310
    tldr
    tmux
    tree
    zoxide
    zsh-powerlevel10k
    zsh-fzf-tab
    commitizen
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
      Numbers = 409203825;
      Pages = 409201541;
      Keynote = 409183694;
      Bitwarden = 1352778147;
    };

    taps = [ ];

    # `brew install`
    brews = [
      "wget"
      "curl" # do not install curl via nixpkgs, it's not working well on macOS!
      "nvm"
      "uv"
      "openjdk"
      "openjdk@21"
      "openjdk@17"
      "neovim"
      "ripgrep"
    ];

    # `brew install --cask`
    casks = [
      "alt-tab"
      "bruno"
      "discord"
      "google-chrome"
      "iina"
      "intellij-idea"
      "jordanbaird-ice"
      "keka"
      "raycast"
      "rectangle"
      "slack"
      "stats"
      "telegram"
      "visual-studio-code"
      "zoom"
      "claude"
      "batfi"
      "docker-desktop"
      "cursor"
      "daisydisk"
      "ghostty"
      "hammerspoon"
      "hancom-docs"
      "logi-options+"
      "notion"
      "onyx"
      "shottr"
      "arc"
      "obsidian"

      # Fonts
      "font-fontawesome"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "font-d2coding"
      "font-fira-code-nerd-font"
      "font-symbols-only-nerd-font"
      "font-material-design-icons-webfont"
      "font-pretendard"
    ];
  };
}
