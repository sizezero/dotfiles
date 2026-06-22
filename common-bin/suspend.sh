#!/bin/bash

help() {
    echo "command takes single argument"
    echo "suspend.sh ( on | off | status ) "
    exit 1
}

if [[ $# -ne 1 || ! $1 =~ ^(on|off|status)$ ]]; then
    help
fi

check_symlink() {
    # terrible variable side effects but that's bash for you
    S="$D/$1.target"
    if [ -L $S ]; then
        echo "found  : $S"
        NONE_FOUND=0
    else
        echo "missing: $S"
        ALL_FOUND=0
    fi
}

case "$1" in
    off)
        sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
        exit 0
    ;;

    on)
        sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
        exit 0
    ;;

    status)
        D=/etc/systemd/system
        ALL_FOUND=1
        NONE_FOUND=1
        check_symlink "sleep"
        check_symlink "suspend"
        check_symlink "hibernate"
        check_symlink "hybrid-sleep"
        check_symlink "suspend-then-hibernate"
        if (( ALL_FOUND == 1 )); then
            echo "all mask symlinks found"
            echo "suspend is OFF"
            exit 0
        elif (( NONE_FOUND == 1 )); then
            echo "no mask symlinks found"
            echo "suspend is ON"
            exit 0
        else
            echo "some mask symlinks found"
            echo "suspend is partially ON, partially OFF"
            exit 1
        fi

    ;;

    *)
        help
    ;;
    
esac
