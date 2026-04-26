{ pkgs, inputs, config, ... }:

{
  programs.niri.enable = true;

  # Portals for screenshare
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
      xdg-desktop-portal-gnome
    ];
    config = { 
      niri = { 
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      };
    };
  };
  

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    mako
    fuzzel
    pavucontrol
    wl-clipboard
    waybar
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "champi";
      };
    };
  };

  # Niri configuration (home manager)
  home-manager.users.champi = {
    xdg.configFile."niri/config.kdl".text = ''
      prefer-no-csd

      // Startup
      spawn-at-startup "xwayland-satellite"
      spawn-at-startup "waybar"
      spawn-at-startup "mako"
      
      // Input
      input {
        keyboard { 
          xkb { 
            layout "es" 
          } 
        }
        touchpad {
          tap
          dwt
        }
        focus-follows-mouse
      }
      
      // Output
      output "eDP-1" {
        mode "1920x1080@60.0"
        scale 1.0
        transform "normal"
        position x=0 y=0
      }
      
      // Layout
      layout {
        gaps 8
        center-focused-column "never"
        default-column-width { proportion 0.5; }
        
        focus-ring {
          width 2
          active-color "#7fc8ff"
          inactive-color "#505050"
        }
      }
      
      // Screenshot path
      screenshot-path "~/Pictures/Screenshots from %Y-%m-%d_%H-%M-%S.png"
      
      // Binds
      binds {
        Alt+Shift+Slash { show-hotkey-overlay; }
        
        // Terminal and launcher
        Alt+Return { spawn "alacritty"; }
        Alt+D { spawn "fuzzel"; }

        // System control
        Alt+Shift+P { power-off-monitors; }
        
        // Window actions
        Alt+Q { close-window; }
        Alt+F { maximize-column; }
        Alt+Shift+F { fullscreen-window; }
        Alt+O { toggle-overview; }
        Alt+C { center-column; }

        Alt+N { set-column-width "-10%"; }
        Alt+M { set-column-width "+10%"; }
        Alt+Shift+N { set-window-height "-10%"; }
        Alt+Shift+M { set-window-height "+10%"; }

        // Focus navigation
        Alt+H { focus-column-left; }
        Alt+J { focus-window-down; }
        Alt+K { focus-window-up; }
        Alt+L { focus-column-right; }
        Alt+Left { focus-column-left; }
        Alt+Down { focus-window-down; }
        Alt+Up { focus-window-up; }
        Alt+Right { focus-column-right; }

        // Move windows
        Alt+Shift+H { move-column-left; }
        Alt+Shift+J { move-window-down; }
        Alt+Shift+K { move-window-up; }
        Alt+Shift+L { move-column-right; }
        Alt+Shift+Left { move-column-left; }
        Alt+Shift+Down { move-window-down; }
        Alt+Shift+Up { move-window-up; }
        Alt+Shift+Right { move-column-right; }

        Alt+BracketLeft { consume-or-expel-window-left; }
        Alt+BracketRight { consume-or-expel-window-right; }

        // Monitors navigation
        Alt+Ctrl+H { focus-monitor-left; }
        Alt+Ctrl+J { focus-monitor-down; }
        Alt+Ctrl+K { focus-monitor-up; }
        Alt+Ctrl+L { focus-monitor-right; }
        Alt+Ctrl+Left { focus-monitor-left; }
        Alt+Ctrl+Down { focus-monitor-down; }
        Alt+Ctrl+Up { focus-monitor-up; }
        Alt+Ctrl+Right { focus-monitor-right; }
       
        // Move window to monitor
        Alt+Shift+Ctrl+H { move-window-to-monitor-left; }
        Alt+Shift+Ctrl+J { move-window-to-monitor-down; }
        Alt+Shift+Ctrl+K { move-window-to-monitor-up; }
        Alt+Shift+Ctrl+L { move-window-to-monitor-right; }
        Alt+Shift+Ctrl+Left { move-window-to-monitor-left; }
        Alt+Shift+Ctrl+Down { move-window-to-monitor-down; }
        Alt+Shift+Ctrl+Up { move-window-to-monitor-up; }
        Alt+Shift+Ctrl+Right { move-window-to-monitor-right; }

        // Workspaces
        Alt+U { focus-workspace-down; } 
        Alt+I { focus-workspace-up; }
        Alt+Ctrl+U { move-window-to-workspace-down; }
        Alt+Ctrl+I { move-window-to-workspace-up; }

        // Mouse scroll
        Alt+WheelScrollDown { focus-workspace-down; }
        Alt+WheelScrollUp { focus-workspace-up; }
        Alt+Shift+WheelScrollDown { move-window-to-workspace-down; }
        Alt+Shift+WheelScrollUp { move-window-to-workspace-up; }

        // Volume controls
        XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0"; }
        XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        // Media controls
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioNext { spawn "playerctl" "next"; } 
        XF86AudioPrev { spawn "playerctl" "previous"; }

        // Brightness Controls
        XF86MonBrightnessUp { spawn "brightnessctl" "set" "+10%"; }
        XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }

        // Screenshots
        Alt+Shift+S { screenshot; }
        Alt+Ctrl+S { screenshot-screen; }

      }
    '';
  };

}
