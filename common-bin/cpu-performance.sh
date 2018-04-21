#!/bin/bash

if [[ $# -ne 1 || ! $1 =~ ^(on|off)$ ]]; then
    echo "command takes single argument"
    echo "cpu-performance ( on | off ) "
    exit 1
fi

if [[ "$1" == "on" ]]; then
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
elif [[ "$1" == "off" ]]; then
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
fi
