#!/bin/bash
set -uex -o pipefail

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"

## GLOBAL

# fix trackpad scroll direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# alwasy show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# load prefered shortcut key settings (does not take effect until logout/login b/c I don't know what process to kill)
defaults import com.apple.symbolichotkeys ./Preferences/com.apple.symbolichotkeys.plist

# custom shortcuts for toggling full screen mode
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Enter Full Screen" "@\\U21a9"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Exit Full Screen" "@\\U21a9"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Toggle Full Screen" "@\\U21a9"

# don't automatically rearrange spaces based on use.
defaults write com.apple.dock mru-spaces -bool false

# Displays should not have separate Spaces
defaults write com.apple.spaces spans-displays -bool true

# force dark mode UI
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

## DOCK

# dock on the right
defaults write com.apple.dock 'orientation' -string 'right'

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# clear the dock of default icons
defaults delete com.apple.dock persistent-apps || true
defaults delete com.apple.dock persistent-others || true

killall Dock || true

## FINDER

# don't warn when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# show hidden files
defaults write com.apple.finder AppleShowAllFiles YES

# show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# show path bar
defaults write com.apple.finder ShowPathbar -bool true

# show internal HD on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# default search scope is current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# open home folder by default
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# don't pollute external drives with .DS_Store crap
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWritoeUSBStores -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

killall Finder || true

## TEXTEDIT

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

killall TextEdit || true

## DISKUTILITY

# show hidden volumes in disk utility
defaults write com.apple.DiskUtility DUShowEveryPartition -bool true

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

killall DiskUtility || true

## MISC
# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# don't show crash report dialog
defaults write com.apple.CrashReporter DialogType none

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable Spotlight indexing for any volume that gets mounted and has not yet been indexed
# Broken in Mojave
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

echo "Done. Please reboot."
