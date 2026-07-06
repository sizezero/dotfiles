#!/bin/bash

help() {
    echo "uses w3m to search either duckduckgo or wikipedia"
    echo "wsearch.sh ( -w | --wikipedia ) 'search string'"
    exit 1
}

MODE=nil
if [[ $# -eq 1 ]]; then
    # default is to search duckduck go
    MODE=ddg
    Q="$1"
else
    if [[ $# -eq 2 ]]; then
        if [[ "$1" == '-w' || "$1" == '--wikipedia' ]]; then
            MODE=wik
            Q="$2"
        else
            help
        fi
    else
        help
    fi
fi

if [[ ! -e /usr/bin/jq ]]; then
    echo "/usr/bin/jq needs to be installed"
    exit 1
fi

if [[ ! -e /usr/bin/w3m ]]; then
    echo "/usr/bin/w3m needs to be installed"
    exit 1
fi

# I'm not sure if I need the printf
# This came from a 'bash escape uri' search
E=$(printf '%s' "$Q" | jq -sRr @uri)

if [[ "$MODE" == "wik" ]]; then
    URL="https://www.wikipedia.org/wiki/$E"
elif [[ "$MODE" == "ddg" ]]; then
    URL="https://www.duckduckgo.com/lite/?q=$E"
else
    echo "uknown mode: $MODE"
    exit 1
fi

w3m "$URL"


