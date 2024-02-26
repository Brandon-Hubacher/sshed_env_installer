function get_packages_for_distro () {
    apps_path="./apps.csv"

    distros=($(head -n 1 "$apps_path" | sed 's/,/ /g' | tr -s ' '))

    for index in "${!distros[@]}"; do
        if [[ "${distros[$index]}" = "$1" ]]; then
            column="$((${index} + 1))";
        fi
    done

    packages=($(cat ./apps.csv | awk -F, {"print "\$${column}} | tr -d '...' | tr -s ' '));
}

. /etc/os-release

get_packages_for_distro "$ID"

# Exclude distribution name from packages
packages="${packages[@]:1:}"

if [ "$ID" = "ubuntu" ]; then
    ./_ubuntu_install.sh "${packages[@]}"
elif [ "$ID" = "rhel" ]; then
    ./_rhel_install.sh "${packages[@]}"
elif [ "$ID" = "arch" ]; then
    ./_arch_install.sh ${packages[@]}
fi

DOTFILES="/home/$(whoami)/dotfiles"
if [ ! -d "$DOTFILES" ]; then
    git clone https://github.com/Brandon-Hubacher/dotfiles.git "$DOTFILES" >/dev/null
    cd "$DOTFILES" && git checkout Work-Laptop
fi

source "$DOTFILES/zsh/.zshenv"
cd "$DOTFILES" && bash install.sh

if ! [ $(ps -p$$ -ocmd=) = "zsh" ]; then
    chsh -s "$(which zsh)" "$(whoami)";
    # reboot required (I think) to change shell
fi
