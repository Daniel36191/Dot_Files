{pkgs, ...}:
{
programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

systemd.user.services.polkit-gnome-authentication-agent-1 = {
  description = "Polkit GNOME Authentication Agent";
  wantedBy = [ "default.target" ];
  serviceConfig = {
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    TimeoutStopSec = 10;
  };
};

services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to NixOS!' --cmd ${windowman}";
      user = username;
    };
    initial_session = {
      command = "${pkgs.${lib.toLower windowman}}/bin/${windowman}";
      user = username;
    };
  };
};

environment.systemPackages = with pkgs; [
hyprcursor
hyprpaper
hyprpicker
waybar
wev # wayland debugger
dunst # Notifcations
libnotify # for dunst
wayvnc # Vnc server

# Clipboard/screenchots
cliphist
grimblast
grim
slurp
wl-clipboard
];
}