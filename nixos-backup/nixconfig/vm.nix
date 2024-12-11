{ config, pkgs, ... }:

{
environment.systemPackages = with pkgs; [
libvirt
qemu
virt-manager # optional for GUI
];

# enable libvirt
virtualisation.libvirtd = {
  enable = true;
  onBoot = "ignore";
  onShutdown = "shutdown";

  qemu = {
  ovmf.enable = true;
  runAsRoot = true; # ths does noting
  };

  #quickfix run hooks manually
  #do not uncomment, doesn't work 
  #hooks.qemu = {   
  #win10 = "/etc/nixos/";
   #};
};

# Enables VM connection
programs.dconf.profiles.user.databases = [
  { lockAll = true;

    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  }
];

# this is breaking things
# bootloader kernal prams
# boot.kernelParams = [
#   "amd_iommu=on" 
#   "iommu=pt" 
#   "vfio-pci.ids=10de:2504,10de:228e"
#    ];
}
