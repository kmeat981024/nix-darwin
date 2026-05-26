{...}: {
  repo.homeModules.desktop = {
    programs.aerospace = {
      enable = true;
      launchd.enable = true;
      settings = {
        start-at-login = true;
        accordion-padding = 10;
        default-root-container-layout = "tiles";
        default-root-container-orientation = "auto";
        on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
        automatically-unhide-macos-hidden-apps = false;

        key-mapping = {
          preset = "qwerty";
        };

        gaps = {
          inner.horizontal = 3;
          inner.vertical = 3;
          outer.left = 3;
          outer.bottom = 3;
          outer.top = 3;
          outer.right = 3;
        };

        mode.main.binding = {
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";
          alt-1 = "workspace --auto-back-and-forth 1";
          alt-2 = "workspace --auto-back-and-forth 2";
          alt-3 = "workspace --auto-back-and-forth 3";
          alt-4 = "workspace --auto-back-and-forth 4";
          alt-5 = "workspace --auto-back-and-forth 5";
          alt-6 = "workspace --auto-back-and-forth 6";
          alt-7 = "workspace --auto-back-and-forth 7";
          alt-8 = "workspace --auto-back-and-forth 8";
          alt-9 = "workspace --auto-back-and-forth 9";
          alt-shift-1 = ["move-node-to-workspace 1" "workspace --auto-back-and-forth 1"];
          alt-shift-2 = ["move-node-to-workspace 2" "workspace --auto-back-and-forth 2"];
          alt-shift-3 = ["move-node-to-workspace 3" "workspace --auto-back-and-forth 3"];
          alt-shift-4 = ["move-node-to-workspace 4" "workspace --auto-back-and-forth 4"];
          alt-shift-5 = ["move-node-to-workspace 5" "workspace --auto-back-and-forth 5"];
          alt-shift-6 = ["move-node-to-workspace 6" "workspace --auto-back-and-forth 6"];
          alt-shift-7 = ["move-node-to-workspace 7" "workspace --auto-back-and-forth 7"];
          alt-shift-8 = ["move-node-to-workspace 8" "workspace --auto-back-and-forth 8"];
          alt-shift-9 = ["move-node-to-workspace 9" "workspace --auto-back-and-forth 9"];
          alt-tab = "workspace-back-and-forth";
          alt-shift-tab = "move-node-to-monitor --wrap-around next";

          cmd-h = [];
          cmd-alt-h = [];

          alt-shift-semicolon = "mode service";
          alt-shift-r = "mode resize";
        };

        mode.service.binding = {
          esc = ["reload-config" "mode main"];
          r = ["flatten-workspace-tree" "mode main"];
          f = ["layout floating tiling" "mode main"];
          backspace = ["close-all-windows-but-current" "mode main"];
          alt-shift-h = ["join-with left" "mode main"];
          alt-shift-j = ["join-with down" "mode main"];
          alt-shift-k = ["join-with up" "mode main"];
          alt-shift-l = ["join-with right" "mode main"];
        };

        mode.resize.binding = {
          minus = "resize smart -50";
          equal = "resize smart +50";
          esc = "mode main";
        };

        on-window-detected = [
          {
            "if".app-id = "com.apple.finder";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.apple.Notes";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.daymore.Across";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.bitwarden.desktop";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "org.hammerspoon.Hammerspoon";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.utmapp.UTM";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.apple.MobileSMS";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "cc.ffitch.shottr";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
          {
            "if".app-id = "com.apple.Preview";
            check-further-callbacks = true;
            run = ["layout floating"];
          }
        ];
      };
    };
  };
}
