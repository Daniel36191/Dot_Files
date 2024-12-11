#!/usr/bin/env bash
# Set environment variables for headless mode
export WLR_BACKENDS=headless
export WLR_LIBINPUT_NO_DEVICES=1
export WAYLAND_DISPLAY=vnc

# Start the headless Wayland session (Hyprland)
Hyprland &

# Wait for Hyprland to start and create a virtual output
sleep 2  # You might need to adjust the sleep time depending on startup time
hyprctl output create "headless_vnc" --mode 1920x1080 --rate 60

# Run WayVNC server, specifying the display
wayvnc -d $WAYLAND_DISPLAY -o "headless_vnc" 0.0.0.0
