#!/bin/bash
source "$(dirname "${BASH_SOURCE[0]}")/z-common.sh"
set -e

LATEST_TAG=$1

info "checking for syncthing updates ..."

pushd "$SYNCTHING_DIR" || cd_fail
git fetch
CURRENT_TAG=$(git describe)
if [ -z "$LATEST_TAG" ]; then
	LATEST_TAG=$(git tag --sort=taggerdate | tail -1)
	info "found tag: $LATEST_TAG"
else
	info "using $LATEST_TAG as tag (command line override)"
fi
popd || cd_fail

if [ "${CURRENT_TAG}" != "${LATEST_TAG}" ]; then
	info "syncthing update found! (${CURRENT_TAG} --> ${LATEST_TAG})"
	info "press enter to update, ctrl+c to exit"
	read -r
	pushd "$SYNCTHING_DIR" || cd_fail

    git checkout -f "${LATEST_TAG}"
    popd || cd_fail
    git add "syncthing/src/github.com/syncthing/syncthing/" || fatal "couldn't add syncthing repo"
    git commit -m "feat: update syncthing to $LATEST_TAG" -e
else
    info "syncthing is up-to-date! ($CURRENT_TAG)"
fi
