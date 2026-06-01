{ pkgs, inputs, ... }:

{
  home-manager.users.champi = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
	  barType = "floating";
          position = "top";
          monitors = [ ];
          density = "compact";
          showOutline = false;
          showCapsule = false;
          widgetSpacing = 2;
          contentPadding = 2;
          fontScale = 1;
          enableExclusionZoneInset = false;
          backgroundOpacity = 0.65;
          useSeparateOpacity = true;
          marginVertical = 5;
          marginHorizontal = 5;
          frameThickness = 5;
          frameRadius = 12;
          outerCorners = true;
          displayMode = "always_visible";
          widgets = {
            left = [
              {
                id = "ControlCenter";
		useDistroLogo = true;
              }
              {
                id = "Bluetooth";
              }
              {
                id = "Volume";
              }
              {
                id = "Microphone";
              }
	      {
	        id = "NotificationHistory";
		showUnreadBadge = true;
	      }
              {
                id = "Workspace";
		labelMode = "none";
              }
            ];
            center = [
              {
                id = "Clock";
		formatHorizontal = "HH:mm";
              }
            ];
            right = [
              {
                id = "MediaMini";
		hideMode = "Always visible";
		hideWhenIdle = false;
		compactMode = true;
		compactShowAlbumArt = true;
		maxWidth = 500;
		panelShowAlbumArt = true;
		panelShowVisualizer = true;
		showArtistFirst = true;
		showAlbumArt = true;
		showProgressRing = true;
		showVisualizer = true;
		visualizerType = "linear";
              }
	      {
		id = "Tray";
		drawerEnabled = false;
		colorizeIcons = true;
	      }
            ];
          };
          mouseWheelAction = "none";
          reverseScroll = false;
          mouseWheelWrap = false;
          middleClickAction = "none";
          rightClickAction = "controlCenter";
          rightClickFollowMouse = true;
        };
        colorSchemes.predefinedScheme = "Gruvbox";
	general = {
          avatarImage = "${./wallpapers/chen.jpg}";
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = false;
          name = "Galicia, Spain";
        };
	wallaper = {
          directory = "${./wallpapers}";
	};
      };
    };
    home.file.".cache/noctalia/wallpapers.json" = {
      text = builtins.toJSON {
        defaultWallpaper = "${./wallpapers/village.jpg}";
      };
    };
  };
}
