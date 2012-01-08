# alias ls="ls -v"
# export LANG=ja_JP.UTF-8

# for rvm
[[ -n "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# for nvm
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
  nvm use 0.6.7
fi
