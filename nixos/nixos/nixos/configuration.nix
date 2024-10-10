###############################################################
#Run this to stop vs code from asking for permission every time
# "sudo chown -R daniel nixos"
#only needed once
###############################################################
{ config, pkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./apps.nix
      #./vm.nix #Virtual machines
    ];

#Flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ];

#Hyprland
programs.hyprland.enable = true;

#Nvidia
hardware.nvidia.open = true;

hardware.graphics = {
  enable = true;
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

services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia.modesetting.enable = true;

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

#Sound services
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  wireplumber.enable = true;
};

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "daniel";
  nixpkgs.config.allowUnfree = true;

#Fonts
  fonts.packages = with pkgs; [
nerdfonts
];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
#   programs.mtr.enable = true;
#   programs.gnupg.agent = {
#     enable = true;
#     enableSSHSupport = true;
#   };
#   # List services that you want to enable:
# 
#  services.openssh = {
#   enable = true;
#   ports = [ 8443 ];
#   settings = {
#     PasswordAuthentication = true;
#     AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
#     UseDns = true;
#     X11Forwarding = false;
#     PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
#   };
# };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 8443 ];
  # networking.firewall.allowedUDPPorts = [ 8443 ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
