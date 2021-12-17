#!/bin/bash

N="$RANDOM"
# last digit
D="${N: -1}"
# 0 or 1
B=$((D % 2))

if [[ "$B" == 0 ]]; then
    echo "heads"
else
    echo "tails"
fi
