#!/bin/zsh

alias cd..="cd .."
alias gka="gitk --all"
alias gl="git log --oneline --decorate --graph origin/master HEAD"
alias gla="git log --oneline --decorate --graph --all"
alias gup='git checkout origin/master -b gup && git fetch && git checkout - && git branch -D gup'

pushd "$HOME/.dotfiles/" 1>/dev/null || exit
for repo in *; do
  [[ $repo =~ ^[a-z]+$ ]] || continue
    alias ".$repo=git --git-dir=\"$HOME/.dotfiles/$repo\" --work-tree=\"$HOME\""
done
popd 1>/dev/null|| exit
