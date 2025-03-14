#!/usr/bin/env bash
# this script isn't meant to be run directly, it won't do anything.
# it's just helper functions and common code for the other scripts

# colors :3
RESET="\033[0m"
RED="\033[0;31m"
BOLD_RED="\033[1;31m"
CYAN="\033[0;96m"
BOLD_CYAN="\033[1;96m"
LIME="\033[0;92m"
BOLD_LIME="\033[1;92m"
YELLOW="\033[0;33m"
BOLD_YELLOW="\033[1;33m"

# logging functions

debug() {
  [ "$ENABLE_SCRIPT_DEBUG" == "1" ] && printf "(dbg)${YELLOW} %s${RESET}\n" "$1"
}

error() {
    if [ "$2" == "1" ]; then
        printf "        ${RED}%s${RESET}\n" "$1"
    else
        printf "${BOLD_RED}(error)${RED} %s${RESET}\n" "$1"
    fi
}

fatal() {
    if [ "$2" == "1" ]; then
        printf "        ${RED}%s${RESET}\n" "$1"
    else
        printf "${BOLD_RED}(fatal)${RED} %s${RESET}\n" "$1"
    fi
    exit 1
}

warn() { printf "${BOLD_YELLOW}(warn)${YELLOW} %s${RESET}\n" "$1"; }

info() { printf "${BOLD_CYAN}(info)${CYAN} %s${RESET}\n" "$1"; }

cd_fail() {
    error "failed to change directory - line $(caller)"
    exit 1
}

success() {
    if [ "$2" == "1" ]; then
        printf "          ${LIME}%s${RESET}\n" "$1"
    else
        printf "${BOLD_LIME}(success)${LIME} %s${RESET}\n" "$1"
    fi
}

# variables
PROJECT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")"/../)"
SYNCTHING_DIR="$PROJECT_DIR/syncthing/src/github.com/syncthing/syncthing"
debug "project directory: $PROJECT_DIR"
