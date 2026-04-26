{ pkgs, ...}:

{
  environment.systemPackages = [ pkgs.alacritty ];

  home-manager.users.champi = {
    programs.alacritty.enable = true;
  };
}
