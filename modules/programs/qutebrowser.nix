{ pkgs, ... }:

{
  home-manager.users.champi = {
    programs.qutebrowser = {
      enable = true;
      loadAutoconfig = false;
      
      searchEngines = {
        DEFAULT = "https://duckduckgo.com/?q={}";
        "!g"    = "https://google.com/search?q={}";
        "!nw"   = "https://wiki.nixos.org/w/index.php?search={}";
        "!yt"   = "https://youtube.com/results?search_query={}";
      };

      settings = {
        qt.args = [ "enable-gpu-rasterization" "ignore-gpu-blocklist" ];
        colors.statusbar.normal.bg = "#282828";
        colors.statusbar.normal.fg = "#ebdbb2";
      };

      keyBindings = {
        normal = {
          "<Alt-r>" = "config-source";
        };
      };
    };
  };
}
