if which op; then
    await_user_action "Extract id_rsa(.pub) and id_ed25519(.pub) from 1password to .ssh"
else
    # install secrets
    op list vaults || eval $(op signin my.1password.com 1password@mjeffryes.net)

    function extract {
        file=$1
        touch "${HOME}/.ssh/$file"
        chmod 600 "${HOME}/.ssh/$file"
        op get document $file > "${HOME}/.ssh/$file"
    }

    extract id_rsa
    extract id_rsa.pub
    extract id_ed25519
    extract id_ed25519.pub
fi

# add ssh identity to keychain
ssh-add -K "$HOME/.ssh/id_rsa"

# add ssh identity to keychain
ssh-add -K "$HOME/.ssh/id_ed25519"

