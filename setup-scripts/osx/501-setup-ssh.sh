set -euo pipefail

mkdir -p "${HOME}/.ssh"

if which op; then
    # install secrets
    op whoami || eval $(op signin)

    function extract {
        file=$1
        touch "${HOME}/.ssh/$file"
        chmod 600 "${HOME}/.ssh/$file"
        op document get $file > "${HOME}/.ssh/$file"
    }

    extract id_rsa
    extract id_rsa.pub
    extract id_ed25519
    extract id_ed25519.pub
else
    await_user_action "Extract id_rsa(.pub) and id_ed25519(.pub) from 1password to .ssh"
fi

# add ssh identity to keychain
ssh-add --apple-use-keychain "$HOME/.ssh/id_rsa"

# add ssh identity to keychain
ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"

