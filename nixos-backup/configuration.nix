{ config, pkgs, inputs, ... }:

{
imports =
  [
    ./hardware-configuration.nix
    ./nixconfig/main.nix
  ];
  
##########
# Flakes #
##########
nix.settings.experimental-features = [ "nix-command" "flakes" ];

########
# Vars #
########
environment.variables = {
  QT_QPA_PLATFORMTHEME = "qt5ct"; # For Qt5 themeing
};

##############
# Bootloader #
##############
boot = {
  loader = {
    grub = {
      enable = true;
      useOSProber = true;
      efiSupport = true;
      device = "nodev";
    };
  efi.canTouchEfiVariables = true;
    timeout = 1;
  };
supportedFilesystems = ["ext4" "exfat" "f2fs" "fat32" "ntfs" ];
};

############
# Location #
############
time.timeZone = "America/New_York";
time.hardwareClockInLocalTime = true;
i18n.defaultLocale = "en_US.UTF-8";
i18n.extraLocaleSettings = {
  LC_ADDRESS = "en_US.UTF-8";
  LC_IDENTIFICATION = "en_US.UTF-8";
  LC_MEASUREMENT = "en_US.UTF-8";
  LC_MONETARY = "en_US.UTF-8";
  LC_NAME = "en_US.UTF-8";
  LC_NUMERIC = "en_US.UTF-8";
  LC_PAPER = "en_US.UTF-8";
  LC_TELEPHONE = "en_US.UTF-8";
  LC_TIME = "en_US.UTF-8";
};
services.xserver.xkb = {
  layout = "us";
  variant = "";
};

################
# Nixos Config #
################
nixpkgs.config.allowUnfree = true;
system.stateVersion = "24.11";
# system.stateVersion = "unstable";
}
