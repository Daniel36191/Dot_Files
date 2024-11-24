{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./config/main.nix
    ];

#Flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ];

#Envroment Vars
environment.variables = {
  QT_QPA_PLATFORMTHEME = "qt5ct"; # For Qt5 themeing
};

#GreetD
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to NixOS!' --cmd Hyprland";
        user = "daniel";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "daniel";
      };
    };
  };

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
    extraEntries = ''
  menuentry "Windows Boot Manager" {
    insmod part_gpt
    insmod fat
    set root='hd0,gpt1'
    if [ x$feature_platform_search_hint = xy ]; then
     search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  82AC-4EE9
    else
     search --no-floppy --fs-uuid --set=root 82AC-4EE9
    fi
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
  }
'';
  };
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ext4" "exfat" "f2fs" "fat32" "ntfs" ];

  #Security
  security.polkit.enable = true;
  security.rtkit.enable = true;
#Add exception for grub reboot for windwos reboot command in rofi
  security.sudo.extraRules = [
    { users = [ "daniel" ];
      commands = [
        { command = "${pkgs.grub2}/bin/grub-reboot"; options = [ "NOPASSWD" ]; }
        { command = "${pkgs.systemd}/bin/systemctl reboot"; options = [ "NOPASSWD" ]; }
      ];
    }
  ];

  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
   extraConfig = ''
     DefaultTimeoutStopSec=10s
   '';
};



  # Set your time zone.
  time.timeZone = "America/New_York";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# allow unfree
nixpkgs.config.allowUnfree = true;
system.stateVersion = "24.05";
#system.stateVersion = "unstable";
}
