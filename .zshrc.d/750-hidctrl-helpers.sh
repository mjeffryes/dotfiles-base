function caps_as_esc {
  hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'
}

function clear_keymap {
  hidutil property --set '{"UserKeyMapping":[]}'
}

export -f caps_as_esc
export -f clear_keymap
