# use nvim as the default editor if available fall back to vim
best_available="$(command -v nvim || command -v vim || command -v nano || command -v vi)"
export VISUAL="$best_available"
export EDITOR="$best_available"

# steer config files to ~/.config
export XDG_CONFIG_HOME="$HOME/.config"
