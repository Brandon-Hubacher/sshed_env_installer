#!/bin/bash

sudo apt-get update

for elem in "$@"; do
    echo "$elem"

    if [ "$elem" = "diff-so-fancy" ]; then
        echo "Installing diff-so-fancy is not yet implemented"
        continue;
    fi

    if [ "$elem" = "neovim" ]; then
        # Install neovim dependencies
        sudo apt-get install -y ninja-build gettext cmake unzip curl

        git clone https://github.com/neovim/neovim
        cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo

        sudo make install

        export PATH="$HOME/sshed_env_installer/neovim/build/bin:$PATH"

    sudo apt-get install -y "$elem"
done
