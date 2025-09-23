set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim' "Plugin manager

Plugin 'Chiel92/vim-autoformat' "provides autoformatting (when the formatter is installed)
Plugin 'dylon/vim-antlr' "antlr syntax highlighting
Plugin 'mjeffryes/vim-pants' "run pants commands from vim
Plugin 'kevints/vim-aurora-syntax' "aurora file syntax highlighting
Plugin 'niw/vim-pants', {'name': 'pants-syntax'} "pants syntax highlights
Plugin 'rizzatti/dash.vim'
Plugin 'scrooloose/syntastic' "syntax checking
Plugin 'tpope/vim-dispatch' "run make commands in another window
Plugin 'vim-scripts/ucompleteme' "local file based tab completion
Plugin 'sheerun/vim-polyglot' "syntax highlighting for almost everything
Plugin 'airblade/vim-gitgutter' "shows the git diff in the gutter
Plugin 'w0rp/ale' "automatic linting
Plugin 'altercation/vim-colors-solarized' "my color scheme

call vundle#end()
filetype plugin indent on

syntax on
colorscheme solarized
set re=0 "disable painfully slow regex based syntax highlighting

call ucompleteme#Setup()

let g:syntastic_check_on_wq = 0

let g:ale_linters = {
    \ 'dart': ['language_server'],
    \ 'javascript': ['eslint'],
    \ 'typescript': ['tsserver', 'eslint'],
\}

let g:ale_fixers = {
      \ 'go': ['gofmt'],
      \ 'javascript': ['eslint'],
      \ 'javascriptreact': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'typescriptreact': ['eslint']
      \ }
let g:ale_fix_on_save = 1

set updatetime=100 "update stuff like git diff every 100ms

set nu
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

augroup settabstops
  autocmd!
  au filetype scala setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  au filetype python setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
augroup END

augroup setfiletypes
  autocmd!
  au BufRead,BufNewFile *.g set filetype=antlr3
  au BufRead,BufNewFile *.g4 set filetype=antlr4
  au BufRead,BufNewFile *.strato set filetype=scala
augroup END

" install formatter for scala
" we direct stderr to /dev/null b/c it still prints on stderr with --quiet
let g:formatdef_scalafmt = "'scalafmt --stdin 2>/dev/null'"
let g:formatters_scala = ['scalafmt']

"let g:formatters_javascriptreact = ['eslint_local', 'prettier']
"let g:formatters_typescriptreact = ['eslint_local', 'prettier']
"let g:formatters_typescript = ['eslint_local', 'prettier']
let g:formatters_javascript = []
let g:formatters_javascriptreact = []
let g:formatters_typescript = []
let g:formatters_typescriptreact = []

" don't let the autoformatter fall back to the indent file
let g:autoformat_autoindent = 0

" for debugging autoformatting
"let g:autoformat_verbosemode=1

if ! has('nvim')
  " autoformat when writting the buffer
  augroup autoformatonwrite
    autocmd!
    autocmd BufWritePre * :Autoformat
  augroup END
endif

" show tabs, trailing space, EOL, etc.
set list lcs=tab:·⁖,trail:¶,eol:•,extends:↷,precedes:↶
hi NonText ctermfg=5

" highlight search text, as it's typed
set hlsearch incsearch

" highlight column 100
set cc=100

" write the buffer when moving between buffers or running :make or :!
set autowrite

" for less beeping
set visualbell

" enable background buffers http://items.sjbach.com/319/configuring-vim-right
set hidden

" shell-like command autocompletion
set wildmenu
set wildmode=list:longest

" set the title of the terminal window
set title

" make backspace work in insert mode
set backspace=indent,eol,start

set spell spelllang=en_us

command SS w | !checkstyle %

set clipboard=unnamed

if has("cscope")
  set csto=0
  set cst
  set nocsverb
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  " add any database in current directory
  if filereadable("cscope.out")
    cs add cscope.out
    nmap <F5> :!cscope -R -b -q <CR> :csreset <CR>
  endif
  set csverb
endif

" GitBrowse invokes git-browse with the current file and lines and copies the
" url to clipboard.
function! GitBrowse() abort
  let l:branch  = trim(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'))
  let l:filename = trim(system('git ls-files --full-name ' . expand('%')))
  let l:remote = trim(system('git config branch.'.l:branch.'.remote || echo "origin" '))
  " let l:cmd = 'git browse ' . l:remote . ' ' . l:filename
  let l:cmd = 'git browse ' . l:remote . ' ' . l:filename . ' ' . a:firstline . ' ' . a:lastline
  echo l:cmd
  let l:url = system(l:cmd)
  let @* = l:url
  echo l:url
endfunction

command! -range GBrowse <line1>,<line2> call GitBrowse()

nnoremap <F7> :GBrowse <cr>
nnoremap <F6> :Dash<cr>
