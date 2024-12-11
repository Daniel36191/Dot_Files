{ config, pkgs, inputs, ... }:
{
services.avahi = {
enable = true;
publish.userServices = true;
publish.enable = true;
openFirewall = true;
};

services.monado.enable = true;
# networking.firewall = {
# allowedTCPPorts = [ 9757 ];
# allowedUDPPorts = [ 5353 9757 ];
# };

# programs.alvr = {
#   enable = true;
#   openFirewall = true;
# };

environment.systemPackages = with pkgs; [
  opencomposite
  opencomposite-helper
];
}