# Prompt
setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt
autoload -U colors
colors

EXIT_PROMPT="%(?.%?.%{%B%}%K{red}%?%{%k%}%{%b%}"
PROMPT="   λ %{${fg[green]}%}%(!.#.:)%{${reset_color}%} "
RPROMPT='[%~]$(vcs_info_with_color)$EXIT_PROMPT'

# Aliases
alias be='bundle exec'
alias g='git'
alias ls='ls -G'
alias n='npm'
alias o='open'
alias r='rails'
alias e='ember'
alias vi='nvim'
alias dc='docker-compose'
alias reload='source ~/.zshrc'
alias nom='npm cache clear && rm -rf node_modules && npm install'
alias nombom='npm cache clear && bower cache clean && rm -rf node_modules bower_components && npm install && bower install'

alias -g C="| pbcopy"
alias -g J="| json"
alias -g L="| lv"
alias -g V='| vi -R -'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history

# VSC
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-%b'
zstyle ':vcs_info:*' actionformats '(%s)-%b|%a'

function _precmd_vcs_info() {
  LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _precmd_vcs_info
function vcs_info_for_git() {
  VCS_GIT_PROMPT="${vcs_info_msg_0_}"
  VCS_GIT_PROMPT_CLEAN="%{${fg[green]}%}"
  VCS_GIT_PROMPT_DIRTY="%{${fg[yellow]}%}"

  VCS_GIT_PROMPT_ADDED="%{${fg[cyan]}%}A%{${reset_color}%}"
  VCS_GIT_PROMPT_MODIFIED="%{${fg[yellow]}%}M%{${reset_color}%}"
  VCS_GIT_PROMPT_DELETED="%{${fg[red]}%}D%{${reset_color}%}"
  VCS_GIT_PROMPT_RENAMED="%{${fg[blue]}%}R%{${reset_color}%}"
  VCS_GIT_PROMPT_UNMERGED="%{${fg[magenta]}%}U%{${reset_color}%}"
  VCS_GIT_PROMPT_UNTRACKED="%{${fg[red]}%}?%{${reset_color}%}"

  INDEX=$(git status --porcelain 2> /dev/null)
  if [[ -z "$INDEX" ]];then
    STATUS="${VCS_GIT_PROMPT_CLEAN}${VCS_GIT_PROMPT}%{${reset_color}%}"
  else
    STATUS=" ${VCS_GIT_PROMPT_DIRTY}${VCS_GIT_PROMPT}%{${reset_color}%}"
    if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNMERGED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^R ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_RENAMED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_DELETED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_UNTRACKED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_MODIFIED$STATUS"
    fi
    if $(echo "$INDEX" | grep '^A ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED$STATUS"
    elif $(echo "$INDEX" | grep '^M ' &> /dev/null); then
      STATUS="$VCS_GIT_PROMPT_ADDED$STATUS"
    fi
  fi
  echo "${STATUS}"
}
function vcs_info_with_color() {
  VCS_PROMPT_PREFIX="%{${fg[green]}%}[%{${reset_color}%}"
  VCS_PROMPT_SUFFIX="%{${fg[green]}%}]%{${reset_color}%}"

  VCS_NOT_GIT_PROMPT="%{${fg[green]}%}${vcs_info_msg_0_}%{${reset_color}%}"

  if [[ -n "${vcs_info_msg_0_}" ]]; then
    if [[ "${vcs_info_msg_1_}" = "git" ]]; then
      STATUS=$(vcs_info_for_git)
    else
      STATUS=${VCS_NOT_GIT_PROMPT}
    fi
    echo "${VCS_PROMPT_PREFIX}${STATUS}${VCS_PROMPT_SUFFIX}"
  fi
}

# Others
## rbenv
if which rbenv > /dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi
## z
if [ `brew --prefix z 2> /dev/null` ]; then
  . `brew --prefix z`/etc/profile.d/z.sh
fi
## Go
export GOPATH=~
PATH=$PATH:$GOPATH/bin
## Git
export EDITOR=nvim # not `vi`
## Packages installed via brew
export PATH=/usr/local/bin:$PATH

# Competition
fpath=(`brew --prefix`/share/zsh/site-functions $fpath)
zstyle ':completion:*:default' menu select=2
if [ `brew --prefix zsh-completions 2> /dev/null` ]; then
  fpath=(`brew --prefix`/share/zsh-completions $fpath)
fi
if which ghq > /dev/null 2>&1; then
  fpath=($GOPATH/src/github.com/motemen/ghq/zsh $fpath)
fi
autoload -U compinit
compinit

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# direnv
if which direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# for my local config
if ls ~/.zsh.d > /dev/null 2>&1; then
  source ~/.zsh.d/*
fi

export PATH="$HOME/.yarn/bin:$PATH"
