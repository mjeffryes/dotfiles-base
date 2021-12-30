# use starship for the prompt

eval "$(starship init zsh)"

# starship doesn't set the prompt2 (eg. used in HERE doc), so do it manually
PROMPT2='%{${fg[white]}%}◀%{$reset_color%} '

