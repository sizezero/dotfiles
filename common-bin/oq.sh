#!/bin/bash

help() {
    echo "oq.sh '<search phrase>' > answer.md"
    exit 1
}

if [[ $# -ne 1 ]]; then
    help
fi

S="$1"

ollama run gemma4 --nowordwrap "${S}"

#echo "s${S}e"
