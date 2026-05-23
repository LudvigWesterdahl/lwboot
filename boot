#!/bin/sh
set -e
set -u

readonly req_dir_1_ssh="${2}"
readonly req_dir_2_lwboot="${1}"
readonly req_file_1_key="id_rsa"
readonly req_file_2_pub="id_rsa.pub"

require_file() {
    arg_file="${1}"

    if [ ! -f "${arg_file}" ]; then
        echo "missing file ${arg_file}"
        return 1
    fi

    return 0
}

require_dir() {
    arg_dir="${1}"

    if [ ! -d "${arg_dir}" ]; then
        echo "missing dir ${arg_dir}"
        return 1
    fi

    return 0
}

require_dir "${req_dir_1_ssh}"
require_dir "${req_dir_2_lwboot}"
require_file "${req_file_1_key}"
require_file "${req_file_2_pub}"

echo "copying ssh files into: ${req_dir_1_ssh}"
chmod 400 "${req_file_1_key}"
chmod 444 "${req_file_2_pub}"
cp "${req_file_1_key}" "${req_dir_1_ssh}"
cp "${req_file_2_pub}" "${req_dir_1_ssh}"

echo "upgrading pacman"
sudo pacman --noconfirm -Syu
sudo pacman --noconfirm -Fy

echo "installing git"
sudo pacman --noconfirm -S "extra/git"

echo "cloning lwboot repository into: ${req_dir_2_lwboot}"
git clone git@github.com:LudvigWesterdahl/lwboot.git "${req_dir_2_lwboot}/lwboot"

