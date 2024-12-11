{pkgs, ...}:
{
services.xserver = {
  enable = true;
  displayManager.gdm.enable = true;
  desktopManager.gnome.enable = true;
};

# Conflict with pipewire when installing gnome
hardware.pulseaudio.enable = false;

environment.gnome.excludePackages = with pkgs; [
  gedit
  gnome-connections
  gnome-console
  gnome-photos
  gnome-tour
  snapshot
  atomix # puzzle game
  baobab # disk usage analyzer
  cheese # webcam tool
  epiphany # web browser
  evince # document viewer
  geary # email reader
  gnome-calendar
  gnome-characters
  gnome-clocks
  gnome-contacts
  gnome-disk-utility
  gnome-font-viewer
  gnome-logs
  gnome-maps
  gnome-music
  gnome-shell-extensions
  gnome-system-monitor
  gnome-terminal
  gnome-weather
  hitori # sudoku game
  iagno # go game
  simple-scan
  tali # poker game
  yelp # help viewer
];

environment.systemPackages = with pkgs; [
  gnome-tweaks
  # Extetntions #
  gnomeExtensions.user-themes
  # gnomeExtensions.forge # broken tiling
];
}