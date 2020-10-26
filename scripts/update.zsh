#!/bin/zsh

PATH="/usr/local/bin:/$HOME/Library/Python/3.7/bin:$PATH"
source "$DOTDIR/zsh/env.zsh"

eval "$(fnm env)"

trap 'ret=$?; test $ret -ne 0 && terminal-notifier -group "Upgrade script error" -title "Upgrade script" -message "Upgrade script encountered an error! Check the logs for details."; exit $ret' EXIT
set -e

terminal-notifier -title "Upgrade script" -message "Running upgrade script" -group "Upgrade script"

printf "Running brew update...\n"            | ts
brew update
printf "\n\n\n"

printf "Running brew upgrade...\n"           | ts
brew upgrade --fetch-HEAD
printf "\n\n\n"

printf "Running brew cask upgrade...\n"      | ts
env SUDO_ASKPASS="$HOME/.askpass" \
brew upgrade --cask --force
printf "\n\n\n"

printf "Running brew cleanup...\n"           | ts
brew cleanup
printf "\n\n\n"

printf "Updating Node installation...\n"     | ts
fnm install "$NODE_VERSION" && fnm use "$NODE_VERSION" && fnm default $(fnm current)
printf "\n\n\n"

printf "Installing global NPM packages...\n" | ts
npm install -g \
  $(cat "$DOTDIR/npm-global-packages" | tr '\n' ' ') >/dev/null
printf "\n\n\n"

printf "Updating TLDR local data...\n"       | ts
tldr --update
printf "\n\n\n"

printf "Updating antibody plugins...\n"      | ts
antibody bundle < "$DOTDIR/zsh/zsh_plugins" > ~/.zsh_plugins
printf "\n\n\n"

printf "Updating Python packages...\n"       | ts
pip-review --auto
printf "\n\n\n"

terminal-notifier -title "Upgrade script" -message "Finished running upgrade script" -group "Upgrade script"
printf     "\n\n\n"
