{pkgs, ...}:
{
services = {
  xserver.enable = true;
  desktopManager.plasma6.enable = true;
  displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
};

services.xrdp = {
  enable = true;
  defaultWindowManager = "startplasma-x11";
  openFirewall = true;
};

environment.plasma6.excludePackages = with pkgs.kdePackages; [
  plasma-browser-integration
  konsole
  elisa
];

environment.systemPackages = with pkgs; [
adwaita-icon-theme
libsForQt5.krdc
catppuccin-kde
kdePackages.krfb
];
}