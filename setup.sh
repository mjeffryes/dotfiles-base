#!/bin/bash
set -uex -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"

# initialize submodules
git submodule init
git submodule update

# install vim plugins
vim +PluginInstall +qall

# install secrets
op list vaults || eval $(op signin my.1password.com 1password@mjeffryes.net)
touch "${HOME}/.ssh/id_rsa"
chmod 600 "${HOME}/.ssh/id_rsa"
op get document id_rsa > "${HOME}/.ssh/id_rsa"

# add ssh identity to keychain
ssh-add -K .ssh/id_rsa

touch "${HOME}/.ssh/id_ed25519"
chmod 600 "${HOME}/.ssh/id_ed25519"
op get document id_ed25519 > "${HOME}/.ssh/id_ed25519"

# add ssh identity to keychain
ssh-add -K .ssh/id_ed25519
