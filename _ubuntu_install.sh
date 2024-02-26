#!/bin/bash

sudo apt-get update

for elem in "$@"; do
    echo "$elem"

    if [ "$elem" = "diff-so-fancy" ]; then
        mkdir -p "$HOME/bin"
        export PATH="$PATH:$HOME/bin"
        cd "$HOME/bin"
        git clone https://github.com/so-fancy/diff-so-fancy diffsofancy
        chmod +x diffsofancy/diff-so-fancy
        ln -s "$HOME/bin/diffsofancy/diff-so-fancy" "$HOME/bin/diff-so-fancy"
    fi

    if [ "$elem" = "neovim" ] && ! [ $(command -v nvim) ]; then
        # Install neovim dependencies
        sudo apt-get install -y ninja-build gettext cmake unzip curl

        git clone https://github.com/neovim/neovim
        cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo

        sudo make install

        export PATH="$HOME/sshed_env_installer/neovim/build/bin:$PATH"
    fi

    sudo apt-get install -y "$elem"
done
