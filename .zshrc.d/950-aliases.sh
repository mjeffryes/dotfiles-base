#!/bin/zsh

alias cd..="cd .."
alias gka="gitk --all"
alias gl="git log --oneline --decorate --graph origin/master HEAD"
alias gla="git log --oneline --decorate --graph --all"
alias gup='git checkout origin/master -b gup && git fetch && git checkout - && git branch -D gup'

alias vvim=/usr/bin/vim
alias vim=nvim

# aliases for working with each dotfiles repo
pushd "$HOME/.dotfiles/" 1>/dev/null || exit
for repo in *; do
  [[ $repo =~ ^[a-z]+$ ]] || continue
  alias ".$repo=git --git-dir=\"$HOME/.dotfiles/$repo\" --work-tree=\"$HOME\""
done
popd 1>/dev/null || exit

# helper function for devbox shell that automatically identifies if we need to switch to a new shell
devboxdir="$HOME/.devboxdir"
dbs() {
  if [ -f "$devboxdir" ]; then
    [ -z "$VERBOSE" ] ||
      echo devbox dir set, cd there before continuing
    cd -q "$(cat "$devboxdir")" || echo "Warning: couldn't find saved devboxdir: $(cat $devboxdir)"
    rm "$devboxdir"
  fi

  if ! [ -f "devbox.json" ]; then
    [ -z "$VERBOSE" ] || echo "This isn't a devbox root, nothing to do"
    return
  fi

  if [ -n "${DEVBOX_PROJECT_ROOT:-}" ]; then
    if [[ "$(pwd -P)" == "$(
      cd -q "$DEVBOX_PROJECT_ROOT" || exit 0
      pwd -P
    )" ]]; then
      [ -z "$VERBOSE" ] || echo "We're in the DEVBOX_PROJECT_ROOT, nothing to do."
      return
    fi

    [ -z "$VERBOSE" ] || echo "Need to exit out of the current devbox shell to enter the new one"
    pwd >"$devboxdir"
    exit
  fi

  [ -z "$VERBOSE" ] || echo "We're in a devbox root with a clean shell, enter the devbox shell"
  #trap dbs EXIT # register a trap to check again after the devbox shell exits
  # disable recompute for a faster startup
  devbox shell --recompute=0
  dbs
  DEPTH="$((DEPTH--))"
}

#aliases for tailing q logs
qq() {
  clear

  logpath="$TMPDIR/q"
  if [[ -z "$TMPDIR" ]]; then
    logpath="/tmp/q"
  fi

  if [[ ! -f "$logpath" ]]; then
    echo 'Q LOG' >"$logpath"
  fi

  tail -100f -- "$logpath"
}

rmqq() {
  logpath="$TMPDIR/q"
  if [[ -z "$TMPDIR" ]]; then
    logpath="/tmp/q"
  fi
  if [[ -f "$logpath" ]]; then
    rm "$logpath"
  fi
  qq
}
