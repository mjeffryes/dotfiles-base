#!/bin/zsh

# shadow the brew command to prevent accidental use
alias brew="echo 'Please use brew_up or brew_add instead of brew directly'"
alias brew_for_real='command brew'

# Aliases for managing Homebrew packages with a Brewfile
alias brew_add='brew_for_real bundle add --file="$HOME/.config/homebrew/Brewfile'
alias brew_up='brew_for_real bundle install --file=- < "$HOME"/.config/homebrew/Brewfile*'
