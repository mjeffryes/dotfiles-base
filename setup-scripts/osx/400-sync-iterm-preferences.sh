#!/bin/bash
set -uex -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"

# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${script_dir}/Preferences/iterm"

# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Tell iTerm2 to sync changes automatically
defaults write com.googlecode.iterm2 "NoSyncNeverRemindPrefsChangesLostForFile_selection" -int 2
