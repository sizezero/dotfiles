#!/bin/bash

if [[ $# -ne 1 || ! $1 =~ ^(on|off)$ ]]; then
    echo "command takes single argument"
    echo "hibernate.sh ( on | off ) "
    exit 1
fi

case "$1" in
    off)
        sudo systemctl mask hibernate.target hybrid-sleep.target suspend-then-hibernate.target
    ;;

    on)
        sudo systemctl unmask hibernate.target hybrid-sleep.target suspend-then-hibernate.target
    ;;

    *)
        echo "single argument must be on or offfo"
    ;;
    
esac
