#!/bin/bash

set euo pipefail

# processes the json file obtained from https://easyretro.io/profile?tab=data in to markdown tables
cat | jq '
.publicBoards[] | 
  .messages as $messages | 
  .columns | map(
    .id as $colid |
      { 
        value, 
        msg: $messages | map(select(.type.id == $colid)) | map({ text, votes: .votes | length }) }
  )' | jq -r '
  map([.value, "----"] + (.msg | map((.text | gsub("\n";"<br>")) + " " + ("👍" * .votes) ))) |
  transpose |
  .[] |
  join(" | ") |
  "| " + . + " |"
  '
