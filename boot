#!/bin/bash

readonly PROG_PATH=${0}
readonly PROG_DIR=${0%/*}
readonly PROG_NAME=$(basename $0)

notify() {
    echo "${PROG_NAME}: $1"
    return 0
}

error() {
    echo 1>&2 "${PROG_NAME}: $1"
    return 0
}

print_usage() {

    echo "Usage: ${PROG_NAME} <arg1> <arg2> [options...]"
    echo
    echo "Arguments:"
    echo " <install>          Runs the boot install"
    echo
    echo "Options:"
    echo " -d, <var>          The folder to pull lwboot repository in"
    echo " -s, <val>          The .ssh folder"

    return 0
}

main() {
    declare -ri NUM_ARGS=1

    if [ "${1}" == "-h" ] || [ "${1}" == "--help" ]; then
	      print_usage
	      return 0
    fi

    if [[ $# -lt ${NUM_ARGS} ]]; then
        notify "try '${PROG_NAME} -h' or '${PROG_NAME} --help' for more information"
        return 1
    fi

    declare ARG=${1}

    declare D_FLAG=""
    declare S_FLAG=""

    declare -i I=$NUM_ARGS
    I=I+1
    while [ $I -le $# ]; do
        case ${!I} in
            "-d")
                I=I+1
                D_FLAG=${!I}
                ;;
            "-s")
                I=I+1
                S_FLAG=${!I}
                ;;
            *)
                notify "${!I} does not match any supported option"
                ;;
        esac
        I=I+1
    done

    if [[ "${ARG}" == "install" ]]; then
      if [[ "${D_FLAG}" == "" ]]; then
          error "missing -d flag for ${ARG}"
          return 1
      fi

      if [[ "${S_FLAG}" == "" ]]; then
          error "missing -s flag for ${ARG}"
          return 1
      fi

      if [[ ! -d "${D_FLAG}" ]]; then
          error "folder ${D_FLAG} does not exist"
          return 1
      fi

      if [[ ! -d "${S_FLAG}" ]]; then
          error "folder ${S_FLAG} does not exist"
          return 1
      fi

      declare KEY_FILE="id_rsa"
      declare KEY_FILE_PUB="${KEY_FILE}.pub"

      if [[ ! -f "${KEY_FILE}" ]]; then
          error "file ${KEY_FILE} does not exist, put it beside this script"
          return 1
      fi

      if [[ ! -f "${KEY_FILE_PUB}" ]]; then
          error "file ${KEY_FILE_PUB} does not exist, put it beside this script"
          return 1
      fi

      if [[ -z $(command -v git) ]]; then
          error "git could not be found, install by running 'sudo pacman -S git'"
          return 1
      fi

      if [[ -z $(command -v less) ]]; then
          error "less could not be found, install by running 'sudo pacman -S less'"
          return 1
      fi

      notify "moving ${KEY_FILE} to ${S_FLAG}"
      chmod 400 "${KEY_FILE}"
      cp "${KEY_FILE}" "${S_FLAG}"

      notify "moving ${KEY_FILE_PUB} to ${S_FLAG}"
      chmod 444 "${KEY_FILE_PUB}"
      cp "${KEY_FILE_PUB}" "${S_FLAG}"

      notify "cloning lwboot repository into ${D_FLAG}"
      git clone git@github.com:LudvigWesterdahl/lwboot.git "${D_FLAG}/lwboot"

      return 0
    fi

    return 0
}

main "${@}"
