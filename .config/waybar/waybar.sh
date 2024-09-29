watch -d -t -g ls -lR && pkill waybar
wait
kitty -e waybar
kitty -e ./waybar.sh