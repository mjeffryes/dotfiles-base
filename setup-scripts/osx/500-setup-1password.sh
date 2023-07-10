
nohup "/Applications/1Password"*".app/Contents/MacOS/1Password"* &
await_user_action "unlock 1password vault and install any updates"

await_user_action "enable cli access in 1password settings"

