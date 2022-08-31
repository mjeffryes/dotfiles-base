#!/bin/sh
# Formats copy paste from slack for better pasting into things like Paper
# First puts "names" on their own line, and removes times.
# Then removes standalone times
# Then removes the "instant emoji" reactions that crop up in my pastes alot
# then removes duplicate whitespace (cat -s)
slackfmt() {
  pbpaste | sed -E $'s/(.*)  [0-9]:[0-9][0-9]( AM| PM)/\\\n**\\1**/' | sed "/[0-9]:[0-9][0-9]/d" | sed "/^gradient-wave-blob/d" | sed "/^eyes/d" | sed "/^llamayay/d" | cat -s
}
