{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      jellyfin-tui
   ];

   # Config file in ~/.config/jellyfin-tui/config.yaml
   #
   # Minumum config:
   # 
   # servers:
   # - name: Home Server
   # password: --password--
   # url: --server-url--
   # username: --username--
   # 
   # Optional config:
   # 
	# # Show album cover image
	# art: true
	# # Save and restore the state of the player (queue, volume, etc.)
	# persist: true
	# # Grab the primary color from the cover image (false => uses the current theme's `accent` instead)
	# auto_color: true
	# # Time in milliseconds to fade between colors when the track changes
	# auto_color_fade_ms: 400
	# # Always show the lyrics pane, even if no lyrics are available
	# lyrics: 'always' # options: 'always', 'never', 'auto'
	# # Swap the play and pause icons
	# swap_play_pause: false
	#
	# # Custom symbols — useful for Nerd Font users. Each character of `spinner` is one animation frame.
	# symbols:
	#   favorite: "♥"
	#   shuffle: "⤮"
	#   play: "►"
	#   pause: "⏸︎"
	#   sleep: "⏾"
	#   downloaded: "⇊"
	#   queued: "◴"
	#   lyrics: "♪"
	#   spinner: "◰◳◲◱"
	#   separator: "›"
	#   disc: "○"
	#
	# rounded_corners: true
	#
	# keymap:
	#   ",": !Volume 1
	#   ".": !Volume -1

}
