#!/bin/bash
set -ueo pipefail

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ensure that brew gets on the path
export PATH="/opt/homebrew/bin:$PATH"
eval $(brew shellenv)

brew bundle --file=- <"$HOME"/.config/homebrew/Brewfile*
