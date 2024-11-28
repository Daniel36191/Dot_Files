{ config, pkgs, inputs, ... }:

#Custom Packages
let
  sendmidi = import (pkgs.fetchFromGitHub {
    owner = "dmoeller131";
    repo = "SendMIDI";
    rev = "main"; # Replace with a specific tag or commit hash
    sha256 = "BIl2KON5I5hDWZJb0wrm25lCuX+/zJF/34SKnUrvcqU="; # Replace with the actual hash
  }) {
    inherit (pkgs) stdenv lib fetchFromGitHub alsa-lib pkg-config; # Pass all required arguments
  };
in

{
  environment.systemPackages = with pkgs; [

# User_Apps
vesktop
librewolf
xarchiver

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
spicetify-cli
pulseaudio
sendmidi

#Plugins
lsp-plugins
cardinal
(cardinal.override { libjack2 = pipewire.jack; })

#Bespoke Synth as app immage
appimage-run

# Games
protonup # Steam_Apps
mangohud # fps_Overlay

# Devolpment
vscode
micro

# CLI
tree

# Razer
# openrazer-daemon # core
# polychromatic # rgb


############
# Non User #
############

# Themeing
catppuccin-cursors.macchiatoDark
catppuccin-gtk
nwg-look
fastfetch
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

############
# Defaults #
############
}
