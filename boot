#!/bin/bash

readonly KEY_FILE="id_rsa"
readonly KEY_FILE_PUB="${KEY_FILE}.pub"
readonly INSTALLER="installer"
readonly INSTALL_GIT="install_git"

readonly REQ_FILES=(
  "${KEY_FILE}"
  "${KEY_FILE_PUB}"
  "${INSTALLER}"
)

readonly LWBOOT_DIR="${1}"
readonly SSH_DIR="${2}"

if [[ ! -d "${LWBOOT_DIR}" ]]; then
    echo "folder to clone lwboot repository into ${LWBOOT_DIR} does not exist"
    exit 1
fi

if [[ ! -d "${SSH_DIR}" ]]; then
    echo "the ssh folder ${SSH_DIR} does  not exist"
    exit 1
fi

declare req_files_exist=0
for REQ_FILE in "${REQ_FILES[@]}"; do
    if [[ ! -f "${REQ_FILE}" ]]; then
        echo "file ${REQ_FILE} does not exist"
        req_files_exist=1
    fi
done

if [[ req_files_exist != 0 ]]; then
  exit 1
fi

source ${INSTALLER}
echo "upgrading pacman..."
pacman_upgrade

source ${INSTALL_GIT}
echo "installing git..."
pacman_install "extra/git"

echo "copying ${KEY_FILE} to ${SSH_DIR}"
chmod 400 "${KEY_FILE}"
cp "${KEY_FILE}" "${SSH_DIR}"

echo "copying ${KEY_FILE_PUB} to ${SSH_DIR}"
chmod 444 "${KEY_FILE_PUB}"
cp "${KEY_FILE_PUB}" "${SSH_DIR}"

echo "cloning lwboot repository into ${LWBOOT_DIR}"
declare LWBOOT_DIR_ABS="${LWBOOT_DIR}/lwboot"
git clone git@github.com:LudvigWesterdahl/lwboot.git "${LWBOOT_DIR_ABS}"

echo "copying ${BRAVE_SYNC_CODE} to ${LWBOOT_DIR_ABS}"
chmod 400 "${BRAVE_SYNC_CODE}"
cp "${BRAVE_SYNC_CODE}" "${LWBOOT_DIR_ABS}"
