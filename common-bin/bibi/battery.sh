#!/bin/bash

# battery percentage
# /sys/class/power_supply/sbs-12-000b/capacity

# Charging status: Charging, Discharging, Full
# $ cat /sys/class/power_supply/sbs-12-000b/status

# shows all power devices
# $ upower -e

upower -i /org/freedesktop/UPower/devices/battery_sbs_12_000b
