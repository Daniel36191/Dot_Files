#!/bin/bash

# Log file for debugging
LOGFILE=~/reboot_log.txt

# Run the command and log output
{
    echo "Running reboot command as daniel"
    sudo -u daniel kitty -e sudo grub-reboot "Windows Boot Manager (on /dev/sdc1)"
    echo "Attempting to reboot"
    sudo -u daniel sudo reboot
} >> "$LOGFILE" 2>&1
