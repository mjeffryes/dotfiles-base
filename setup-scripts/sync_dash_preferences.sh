#!/bin/bash
set -uex -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"

# Specify the preferences directory
defaults write com.kapeli.dash syncFolderPath -string "${script_dir}/Preferences/dash"

# Tell Dash to use the custom preferences in the directory
defaults write com.kapeli.dash dashSyncMigratedToPackage -int 1
defaults write com.kapeli.dash shouldSyncBookmarks -int 1
defaults write com.kapeli.dash shouldSyncDocsets -int 1
defaults write com.kapeli.dash shouldSyncGeneral -int 1
defaults write com.kapeli.dash shouldSyncView -int 1
