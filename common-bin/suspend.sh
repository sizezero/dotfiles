#!/bin/bash

if [[ $# -ne 1 || ! $1 =~ ^(on|off)$ ]]; then
    echo "command takes single argument"
    echo "suspend.sh ( on | off ) "
    exit 1
fi

case "$1" in
    off)
        sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
    ;;

    on)
        sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
    ;;

    *)
        echo "single argument must be on or off"
    ;;
    
esac
