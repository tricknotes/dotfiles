" Vundle: https://github.com/gmarik/Vundle.vim
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'vim-scripts/JavaScript-syntax'

call vundle#end()
filetype plugin indent on

set number
syntax on
set autoindent
set nocompatible
set list
set listchars=eol:-
set smartcase

set smarttab
set tabstop=2
set expandtab
set shiftwidth=2

highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

if has("syntax")
  syntax on
  function! ActivateInvisibleIndicator()
    syntax match InvisibleJISX0208Space "　" display containedin=ALL
    highlight InvisibleJISX0208Space term=underline ctermbg=Red guibg=Red
  endf
  augroup invisible
    autocmd! invisible
    autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
  augroup END
endif

set backspace=indent,eol,start
