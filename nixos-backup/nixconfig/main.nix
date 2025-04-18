{ config, pkgs, inputs, lib, ... }:
#######
# Env #
#######
let
  username = "daniel";
in
{
imports =
  [
    ./apps.nix
    ./startup-apps.nix
    # ./vm.nix
    # ./vr.nix

    #########
    # WM/DE #
    #########
    # ./wm-modules/hyprland.nix
    # ./wm-modules/plasma.nix
    ./wm-modules/gnome.nix
  ];



#######
# SSH #
#######
services.openssh = {
  enable = true;
  #ports = [ 54321 ];
  authorizedKeysInHomedir = true;
  settings = {
    PasswordAuthentication = true;
    AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "without-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    PubkeyAuthentication = "yes";
  };
};

###################
### Core Config ###
###################

########
# Apps #
########
environment.systemPackages = with pkgs; [
# Root Apps
grub2
# polkit
# polkit_gnome

# System_Apps
rofi
kitty
unzip
wget
git
android-tools # ADB
jmtpfs # Connect android files system
networkmanagerapplet
networkmanager_dmenu
stow # Dot file managment
btop

# Sound apps
playerctl
pavucontrol
pulseaudio
];

#########
# Sound #
#########
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  wireplumber.enable = true;
};

########
# Kits #
########
security.polkit = {
  enable = true;
  #package = pkgs.polkit_gnome; #Does not work, still defined in installed apps
};
security.rtkit.enable = true;

##########
# Nvidia #
##########
hardware.graphics = {
  enable = true;
};
services.xserver.videoDrivers = ["nvidia"];

hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
      };
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

##############
# Networking #
##############
networking = {
  hostName = "nixos";
  networkmanager.enable = true;
  firewall = {
  enable = false;
};

  nameservers = [ "192.168.0.141" ];
  dhcpcd.extraConfig = "nohook resolv.conf";
  networkmanager.dns = "none";
};
environment.etc = {
"resolv.conf".text = "# Generated by /etc/nixos/config/main.nix\nnameserver 192.168.0.141\noptions edns0\n 
";
};


########
# User #
########
users.users.${username} = {
  isNormalUser = true;
  description = username;
  extraGroups = [ "networkmanager" "wheel" "openrazer" ];
  packages = with pkgs; [];
  # Set password with passwd
};
services.getty.autologinUser = username;
# No need for sudo passowrd
security.sudo.extraConfig = ''
  daniel ALL=(ALL) NOPASSWD: ALL
'';


# Garbage collection
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};

############
# Boot Win #
############
boot.loader.grub.extraEntries = ''
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
}
