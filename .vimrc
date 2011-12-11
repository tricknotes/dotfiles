" set up for vumble [see: https://github.com/gmarik/vundle ]
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'vim-scripts/jade.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'mattn/lisper-vim'
Bundle 'Shougo/unite.vim'

Bundle 'tricknotes/vim-qwik'

filetype plugin indent on

" 行番号表示
set number
" シンタックスハイライトを利用
syntax on
" 改行時に自動インデントを行う
set autoindent
" vi互換モードを利用しない
set nocompatible
" 不可視文字を表示
set list
set listchars=eol:-
" 検索時に大文字/小文字を判別する
set smartcase

" <Tab>周りの設定
set smarttab
set tabstop=2
" <Tab>を展開する
set expandtab
set shiftwidth=2

" 末尾空白文字を判別する
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

if has("syntax")
" 全角スペースをハイライト
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

" Backspace で文字を削除できるようにする
set backspace=indent,eol,start
