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
# User Apps
vesktop
librewolf
xarchiver

# Media
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
sendmidi
sonobus # sound over wifi

#Plugins
cardinal
# (cardinal.override { libjack2 = pipewire.jack; })

#Bespoke Synth as app immage
appimage-run

# Games
protonup # Steam_Apps
mangohud # fps_Overlay

# Devolpment
vscode
micro

# CLI tools
tree
waypipe # frame buffer sync between 2 pcs
zellij # Terminal Multiplexer

# Razer
# polychromatic # rgb

# Themeing
catppuccin-cursors.macchiatoDark
catppuccin-gtk
nwg-look
fastfetch
nvitop
# mission-center
nerdfonts
(nerdfonts.override { fonts = [ "CascadiaCode" ]; })

];

# For Virtual Here To work
# programs.nix-ld.enable = true;

# For Obs Virtual Cam & usbip for virtual here
boot = {
  extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  kernelModules = [ "v4l2loopback" "usbip" ];
  # kernelModules = [ "snd-seq" "snd-rawmidi" "v4l2loopback" "usbip" ]; #snd-something for obs, idk
};

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
}
