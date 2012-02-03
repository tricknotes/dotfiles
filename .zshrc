# for prompt
setopt prompt_subst
setopt prompt_percent
setopt transient_rprompt
autoload -U colors
colors
# PROMPT="%m %~%{${fg[green]}%}%(!.#.$)%{${reset_color}%} "

alias ls='ls -G'
alias g='git'
alias r='rails'
alias n='npm'
alias be='bundle exec'
alias -g V='| vi -R -'
alias -g C="| pbcopy"

# alias vp='vimpager'

# for homebrew-alt
alias gdb='/usr/local/Cellar/gdb/7.3/bin/gdb'
# alias vim='/usr/local/Cellar/vim/7.3.333/bin/vim'
# alias vi='/usr/local/Cellar/vim/7.3.333/bin/vim'

# for vimpager
# export PAGER=`which vimpager`
# alias less=$PAGER
# alias zless=$PAGER

# git で 独自に入れた vi 使おうとすると落ちるので、とりあえずデフォルトを使うようにしている
export EDITOR=/usr/bin/vi

function cd() {
  builtin cd "$@"
  ls
}

# ヒストリ
## ヒストリを保存するファイル
HISTFILE=~/.zsh_history
## メモリ上のヒストリ数。
## 大きな数を指定してすべてのヒストリを保存するようにしている。
HISTSIZE=10000000
## 保存するヒストリ数
SAVEHIST=$HISTSIZE
## ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する。
setopt extended_history
## 同じコマンドラインを連続で実行した場合はヒストリに登録しない。
setopt hist_ignore_dups
## スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_ignore_space
## すぐにヒストリファイルに追記する。
setopt inc_append_history
## zshプロセス間でヒストリを共有する。
# setopt share_history
## C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control

# 拡張補完 for git://github.com/zsh-users/zsh-completions.git
fpath=(~/.zsh.d/zsh-completions $fpath)
# コマンドに応じた補完
autoload -U compinit
compinit

# for https://github.com/zsh-users/zsh-syntax-highlighting
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# VSC のブランチを右側に表示する
# for vcs info
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s)-%b'
zstyle ':vcs_info:*' actionformats '(%s)-%b|%a'
# function precmd () {
#   psvar=()
#   LANG=en_US.UTF-8 vcs_info
#   [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
# }
# add-zsh-hook precmd _precmd_vcs_info
# RPROMPT="%1(v|%F{green}%1v%f|)"
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
## PROMPT
EXIT_PROMPT="%(?.%?.%{%B%}%K{red}%?%{%k%}%{%b%}"
PROMPT="[%n@%m]%{${fg[green]}%}%(!.#.$)%{${reset_color}%} "
RPROMPT='[%~]$(vcs_info_with_color)$EXIT_PROMPT'

# vi 風のキーバインド
# bindkey -v
# Emacs 風のキーバインド
bindkey -e

# 自動補完の際に ls コマンドと色をそろえる
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
