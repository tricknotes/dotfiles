[[ "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# for nvm-
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
  nvm use 0.6.5
fi

alias ls='ls -G'
alias g='git'
alias r='rails'
alias be='bundle exec'
alias V='| vi -R -'

alias nave='$HOME/.nave/nave/nave.sh'

# for homebrew-alt
alias gdb='/usr/local/Cellar/gdb/7.3/bin/gdb'

function cd() {
  builtin cd "$@"
  ls
}
