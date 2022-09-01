#!/bin/bash
set -euo pipefail # the usual stuff

function .base {
    /usr/bin/git --git-dir="$HOME/.dotfiles/base" --work-tree="$HOME" "$@"
}

git clone --bare https://github.com/mjeffryes/dotfiles-base "$HOME/.dotfiles/base"

if .base checkout; then
    # worked fine, we're done
    echo "Checked out config."
else
    # it failed, so assume we need to move some files out of the way
    echo "Backing up pre-existing dot files."
    files=$(.base checkout 2>&1 | grep -E "^\s+" | awk '{print $1}')  || true
    for f in $files; do mv "$f" "${f}.config-backup"; done
    .base checkout || (echo "Still cannot checkout configs; see messages and fix." && exit 1)
    echo "Restoring pre-existing dot files."
    for f in $files; do mv "${f}.config-backup" "$f"; done
    echo "Checked out config."
fi

export -f .base

os=$(uname -s | tr '[:upper:]' '[:lower:]')
case ${os} in
    darwin) "$HOME/setup-scripts/setup-osx.sh";;
    *) echo "Unrecognized os: $os, skipping setup scripts"
esac
