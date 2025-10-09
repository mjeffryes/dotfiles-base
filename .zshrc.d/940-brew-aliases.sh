#!/bin/zsh

# shadow the brew command to prevent accidental use
brew()  {
  if [[ "$1" == "up" || "$1" == "update" || "$1" == "upgrade" ]]; then
    echo "Please use 'brew_up' instead of 'brew $1'"
  elif [[ "$1" == "install" ]]; then
    echo "Please use 'brew_add' instead of 'brew $1'"
  else
    command brew "$@"
  fi
}

# escape hatch
alias brew_for_real='command brew'

# Aliases for managing Homebrew packages with a Brewfile
brew_up() {
  # update our system to match the Brewfile
  brew bundle install --file=- $@ < "$HOME"/.config/homebrew/Brewfile*
  brew bundle cleanup --file=- < "$HOME"/.config/homebrew/Brewfile*

}
brew_add() {
  # add a package to the Brewfile and install it
  brew bundle add --file="$HOME/.config/homebrew/Brewfile" $@
  brew bundle install --no-upgrade --file=- < "$HOME"/.config/homebrew/Brewfile*
}

