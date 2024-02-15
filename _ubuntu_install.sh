#!/bin/bash

# sudo apt-get update

for elem in "$@"; do
    echo "$elem"

    if [ "$elem" = "diff-so-fancy" ]; then
        echo "Installing diff-so-fancy is not yet implemented"
        continue;
    fi

    # sudo apt-get install "$elem"
done
