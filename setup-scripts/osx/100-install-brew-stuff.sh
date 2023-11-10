#!/bin/bash
set -ueo pipefail

# install brew
which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# ensure that brew gets on the path
export PATH="/opt/homebrew/bin:$PATH"
eval $(brew shellenv)

brew tap mjeffryes/mjeffryes

formulae="
asciinema
atuin
devbox
fd
filesweeper
fzf
gh
jq
reattach-to-user-namespace
rg
starship
shellcheck
terminal-notifier
tmux
vim
zentracker
"

casks="
1password
1password-cli
amethyst
coconutbattery
dash
docker
firefox
flux
google-chrome
grandperspective
iterm2
meetingbar
obsidian
qbserve
quicksilver
resilio-sync
slack
spotify
zoom
"

declare -a failed

tempfile=$(mktemp)

remaining="$formulae"
while [[ $remaining = *[![:space:]]* ]]; do
  fail=""
  echo "Running: brew install $remaining"
  brew install $remaining 2>&1 | tee "$tempfile" || fail=1
  last_tried=$(grep -E "(pouring)|(brew reinstall)" "$tempfile" | tail -n 1 | grep -oE '[^ ]+$')
  if [[ $fail ]]; then failed+=("$last_tried"); fi
  remaining="${remaining#*${last_tried}}"
done

remaining="$casks"
while [[ $remaining = *[![:space:]]* ]]; do
  fail=""
  echo "Running: brew install --cask $remaining"
  brew install --cask $remaining 2>&1 | tee "$tempfile" || fail=1
  last_tried=$(grep -E "(Installing Cask)|(brew reinstall)" "$tempfile" | tail -n 1 | grep -oE '[^ ]+$')
  if [[ $fail ]]; then failed+=("$last_tried"); fi
  remaining="${remaining#*${last_tried}}"
done

if [[ ${#failed[@]} != 0 ]]; then
  echo Failures:
  for f in "${failed[@]}"; do echo "$f": FAILED; done
fi
