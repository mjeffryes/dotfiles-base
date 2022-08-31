# vim mode config
# ---------------

# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup.
echo -ne '\e[5 q'

# Use beam shape cursor for each new prompt.
preexec() {
   echo -ne '\e[5 q'
}


# Set the right keybindings for home/end/del/insert based on terminfo
# Needs to run after activating vim mode
[[ -z "${terminfo[kdch1]}" ]] || bindkey "${terminfo[kdch1]}" delete-char
[[ -z "${terminfo[khome]}" ]] || bindkey "${terminfo[khome]}" beginning-of-line
[[ -z "${terminfo[kend]}" ]] || bindkey "${terminfo[kend]}" end-of-line
[[ -z "${terminfo[kich1]}" ]] || bindkey "${terminfo[kich1]}" overwrite-mode

[[ -z "${terminfo[kdch1]}" ]] || bindkey -M vicmd "${terminfo[kdch1]}" vi-delete-char
[[ -z "${terminfo[khome]}" ]] || bindkey -M vicmd "${terminfo[khome]}" vi-beginning-of-line
[[ -z "${terminfo[kend]}" ]] || bindkey -M vicmd "${terminfo[kend]}" vi-end-of-line
[[ -z "${terminfo[kich1]}" ]] || bindkey -M vicmd "${terminfo[kich1]}" overwrite-mode

# ctrl-r should bring up history search
# needs to run after vim bindings
bindkey '^R' history-incremental-search-backward

# search history with up and down arrows
# needs to run after vim bindings
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search
