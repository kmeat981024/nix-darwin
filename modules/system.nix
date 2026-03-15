{
  pkgs,
  config,
  username,
  hostname,
  ...
}: {
  time.timeZone = "Asia/Seoul";

  system = {
    primaryUser = username;
    stateVersion = 6;

    # symlink /Applications/Nix Apps to /Applications for Spotlight
    activationScripts.extraActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      sudo -u ${username} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = ["/Applications"];
      };
    in
      pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

    defaults = {
      loginwindow = {
        GuestEnabled = false;
      };

      controlcenter = {
        AirDrop = false;
        BatteryShowPercentage = false;
        Bluetooth = false;
        Display = false;
        FocusModes = false;
        NowPlaying = false;
        Sound = false;
      };

      menuExtraClock = {
        Show24Hour = true;
        ShowDayOfWeek = false;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.01;
        autohide-time-modifier = 0.1;
        mineffect = "suck";
        show-recents = false;
        tilesize = 50;
        magnification = true;
        largesize = 70;
        showMissionControlGestureEnabled = true;
      };

      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        ShowStatusBar = true;
        ShowPathbar = true;
        FXPreferredViewStyle = "clmv";
        FXRemoveOldTrashItems = true;
        _FXEnableColumnAutoSizing = true;
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
        _FXSortFoldersFirstOnDesktop = true;
        FXEnableExtensionChangeWarning = false;
        FXDefaultSearchScope = "SCcf";
        NewWindowTarget = "Other";
        NewWindowTargetPath = "/Users/${username}/Downloads";
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowRemovableMediaOnDesktop = true;
        QuitMenuItem = true;
      };

      trackpad = {
        Clicking = true;
        TrackpadRightClick = true; # two finger right click
        TrackpadThreeFingerDrag = true;
        TrackpadFourFingerHorizSwipeGesture = 2; # swipe between full-screen applications
        TrackpadFourFingerVertSwipeGesture = 2; # down for Mission Control, up for App Expose
        TrackpadPinch = true;
        TrackpadThreeFingerHorizSwipeGesture = 0; # disable for three finger drag
        TrackpadThreeFingerVertSwipeGesture = 0; # disable for three finger drag
        TrackpadTwoFingerDoubleTapGesture = true; # smart zoom
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 0;
      };

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };

      smb = {
        NetBIOSName = hostname;
        ServerDescription = hostname;
      };

      WindowManager = {
        AppWindowGroupingBehavior = true;
        EnableStandardClickToShowDesktop = false;
        EnableTilingByEdgeDrag = false;
        EnableTilingOptionAccelerator = false;
        EnableTopTilingByEdgeDrag = false;
        StandardHideDesktopIcons = true;
        StandardHideWidgets = true;
      };

      # Customize settings that not supported by nix-darwin directly
      # source: https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 2;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;

        AppleShowScrollBars = "WhenScrolling";
        AppleScrollerPagingBehavior = true;
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        AppleSpacesSwitchOnActivate = true;

        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 2;

        "com.apple.keyboard.fnState" = true;
        "com.apple.sound.beep.feedback" = 0;
      };

      # Customize settings that not supported by nix-darwin directly
      CustomSystemPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
        "com.apple.dock" = {
          springboard-columns = 10;
          springboard-rows = 10;
          ResetLaunchPad = true;
        };
      };
    };

    keyboard = {
      enableKeyMapping = true; # enable key mapping so that we can use `option` as `control`
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  programs.zsh = {
    enable = true;
  };

  environment = {
    shells = [
      pkgs.zsh
    ];
  };

  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      pretendard
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
      nerd-fonts.d2coding
      nerd-fonts.iosevka
      nerd-fonts.meslo-lg
    ];
  };
}
