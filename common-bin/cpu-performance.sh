#!/bin/bash

if [[ $# -ne 1 || ! $1 =~ ^(on|off)$ ]]; then
    echo "command takes single argument"
    echo "cpu-performance ( on | off ) "
    exit 1
fi


V='performance'
if [[ "$1" == "off" ]]; then
    V='powersave'
fi

echo $V | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
