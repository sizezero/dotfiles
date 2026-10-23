#!/bin/bash

# battery percentage
# /sys/class/power_supply/sbs-12-000b/capacity

# Charging status: Charging, Discharging, Full
# $ cat /sys/class/power_supply/sbs-12-000b/status

# shows all power devices
# $ upower -e

D=/org/freedesktop/UPower/devices/battery_sbs_12_000b

if [ -z "$1" ]; then
    upower -i $D | grep 'percentage'
else
    # any argument shows the verbose output of upower
    upower -i $D
fi
