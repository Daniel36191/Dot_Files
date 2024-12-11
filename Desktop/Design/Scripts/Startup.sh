#!/usr/bin/env bash

# Sound Routing
# Virts to make bespoke work
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=fake-bespoke-source channels=16
pactl load-module module-null-sink media.class=Audio/Sink sink_name=fake-bespoke-output channels=16
# Virts to auto route sptoify
pactl load-module module-null-sink media.class=Audio/Sink sink_name=Spotify-Input channels=2
# Virts to auto route dc and
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Mic-Output channels=1
# Virts to auto route sonobus
pactl load-module module-null-sink media.class=Audio/Sink sink_name=Sonobus-Input channels=2
pactl load-module module-null-sink media.class=Audio/Source/Virtual sink_name=Sonobus-Output channels=1

qpwgraph &
flatpak override --filesystem=~/.themes:ro --filesystem=~/.icons:ro --user &
appimage-run ~/Desktop/Design/Bespoke-Synth/App/bespokesynth-nightly-latest-x86_64.AppImage ~/Desktop/Design/Bespoke-Synth/Saves/main.bsk &
vesktop --ozone-platform=wayland &
