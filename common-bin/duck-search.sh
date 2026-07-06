#!/bin/bash

help() {
    echo "takes single argument"
    echo "duck-search.sh 'search string'"
    exit 1
}

if [[ $# -ne 1 ]]; then
    help
fi

Q="$1"

if [[ ! -e /usr/bin/jq ]]; then
    echo "jq needs to be installed"
    exit 1
fi

# I'm not sure if I need the printf
# This came from a 'bash escape uri' search
E=$(printf '%s' "$Q" | jq -sRr @uri)

URL="https://www.duckduckgo.com/lite/?q=$E"

w3m "$URL"


