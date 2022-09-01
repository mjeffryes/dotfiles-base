#!/bin/bash
set -euo pipefail # the usual stuff

suffix=$1


function .files {
    /usr/bin/git --git-dir="$HOME/.dotfiles/$suffix" --work-tree="$HOME" "$@"
}

git clone --bare "git@github.com:mjeffryes/dotfiles-$suffix" "$HOME/.dotfiles/$suffix"

if .files checkout; then
    # worked fine, we're done
    echo "Checked out config."
else
    # it failed, so assume we need to move some files out of the way
    echo "Backing up pre-existing dot files."
    files=$(.files checkout 2>&1 | grep -E "^\s+" | awk '{print $1}')  || true
    for f in $files; do mv "$f" "${f}.config-backup"; done
    .files checkout || (echo "Still cannot checkout configs; see messages and fix." && exit 1)
    echo "Restoring pre-existing dot files."
    for f in $files; do mv "${f}.config-backup" "$f"; done
    echo "Checked out config."
fi
