call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'

call plug#end()

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

set noswapfile

let g:coc_global_extensions = [
  \ 'coc-solargraph',
  \ 'coc-actions',
  \ 'coc-tsserver',
  \ 'coc-css',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-vimlsp',
  \ 'coc-highlight',
  \ 'coc-ember',
  \ 'coc-markmap'
\ ]

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

colorscheme default
