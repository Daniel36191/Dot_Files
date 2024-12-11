{ config, pkgs, inputs, ... }:
{
# systemd.user.services.flatpaktheme = {
#   enable = true;
#   wantedBy = [ "default.target" ]; # runs with user login
#   description = "Fixes themeing for flatpak apps.";
#   script = ''
#     flatpak override --filesystem=~/.themes:ro --filesystem=~/.icons:ro --user
#   '';
# };

#################
# Sound Routing #
#################
# systemd.user.services.soundfakerouts = {
#   enable = true;
#   wantedBy = [ "default.target" ]; # runs with user login
#   after = [ "xdg-desktop-portal-hyprland.service" ]; #runs after this
#   description = "Fake sinkds and sources for app setting ";
#   script = ''
#     # Virts to make bespoke work \n
#     actl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=fake-bespoke-source channels=16 \n
#     actl load-module module-null-sink media.class=Audio/Sink sink_name=fake-bespoke-output channels=16 \n
#     # Virts to auto route sptoify \n
#     pactl load-module module-null-sink media.class=Audio/Sink sink_name=Spotify-Input channels=2 \n
#     # Virts to auto route dc and \n
#     pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Mic-Output channels=1 \n
#     # Virts to auto route sonobus \n
#     pactl load-module module-null-sink media.class=Audio/Sink sink_name=Sonobus-Input channels=2 \n
#     pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Sonobus-Output channels=1 \n
#   '';
# };
}