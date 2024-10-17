{ config, pkgs, ... }:

let
  # Path to your custom script
  volumeNotifyScript = pkgs.writeShellScriptBin "volume-notify" ''
    #!/usr/bin/env bash

    # Function to get the current volume and muted status
    get_volume() {
      volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
      muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)
    }

    # Initialize the volume and muted status
    get_volume

    # Loop to continuously monitor for volume changes
    while true; do
      # Get the new volume and muted status
      new_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
      new_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep MUTED)

      # Ensure new_volume is numeric, otherwise fallback to old value
      if [ -z "$new_volume" ] || ! [[ "$new_volume" =~ ^[0-9]+$ ]]; then
        new_volume=$volume  # Fallback to the previous volume if new_volume is undefined
      fi

      # If the volume or mute status changes, send a notification
      if [ "$new_volume" != "$volume" ] || [ "$new_muted" != "$muted" ]; then
        if [ "$new_muted" ]; then
          notify-send -u low -t 1000 "Volume: Muted"
        else
          notify-send -u low -t 1000 "Volume: ''${new_volume}%"
        fi

        # Update the current volume and mute status
        volume=$new_volume
        muted=$new_muted
      fi

      # Sleep to prevent excessive CPU usage
      sleep 0.5
    done
  '';

in
{
  systemd.user.services.volume-notify = {
    description = "Volume Change Notification";
    after = [ "graphical-session.target" ];  # Run after the user session starts
    serviceConfig = {
      ExecStart = "${volumeNotifyScript}";
      Restart = "always";  # Restart if the service crashes or exits
    };
    wantedBy = [ "default.target" ];  # Start when the user session starts
  };
}