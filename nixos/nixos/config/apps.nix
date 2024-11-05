{ config, pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [

# User_Apps
vesktop
librewolf

# Media Editing
pinta
obs-studio
vlc
video-trimmer

# Word Editings
xournalpp
obsidian

# Sound
qpwgraph
easyeffects
rnnoise
spicetify-cli

# Games
protonup # Steam_Apps
mangohud # fps_Overlay

# Devolpment
vscode

# Razer
openrazer-daemon # core
polychromatic # rgb


############
# Non User #
############

# Themeing
catppuccin-cursors.macchiatoDark
catppuccin-gtk
nwg-look
neofetch
btop
nvitop
mission-center
nerdfonts
(nerdfonts.override { fonts = [ "CascadiaCode" ]; })

# Hyprland
hyprcursor
hyprpaper
hyprpicker
waybar
wev
dunst # Notifcations
libnotify # for dunst

# Clipboard/screenchots
wl-clipboard
cliphist
grimblast
grim
slurp
];

# For Virtual Here To work
boot.extraModulePackages = with config.boot.kernelPackages; [ usbip ];
programs.nix-ld.enable = true;

# Fonts
fonts.packages = with pkgs; [
  nerdfonts
];
# Flatpacks
services.flatpak.enable = true;

# Cli prompt
programs.starship.enable = true;

# Thunar file manager
programs.thunar = {
  enable = true;
  plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
};
programs.xfconf.enable = true;
services.gvfs.enable = true;

# Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "\${HOME}/.steam/root/compatibilitytools.d";
  };

# Razer support
hardware.openrazer.enable = true;
users.users.daniel = { extraGroups = [ "openrazer" ]; };
}