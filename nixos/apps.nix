{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
#Root Apps
grub2
polkit
polkit_gnome

#System_Apps
rofi
kitty
unzip
wget
git
android-tools #ADB
jmtpfs#Connect android files system
networkmanagerapplet
networkmanager_dmenu
stow#dot files managment

#Themeing
catppuccin-cursors.macchiatoDark
catppuccin-gtk
nwg-look
neofetch
btop
nerdfonts
(nerdfonts.override { fonts = [ "CascadiaCode" ]; })

#Hyprland
hyprcursor
hyprpaper
hyprpicker
waybar
wev
dunst #Notifcations
libnotify #for dunst

#Sound
playerctl
pavucontrol

#Clipboard/screenchots
wl-clipboard
cliphist
grimblast
grim
slurp

#User_Apps
vesktop
obsidian
librewolf
ytfzf #youtube cli
gimp
xournalpp

#Games
protonup #Steam_Apps
mangohud #fps_Overlay

#Sound
qpwgraph
easyeffects
rnnoise
spicetify-cli

#Devolpment
vscode
];

#Thunar file manager
programs.thunar = {
  enable = true;
  plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
};
programs.xfconf.enable = true;
services.gvfs.enable = true;

#Flatpacks
  services.flatpak.enable = true;

#Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };
}