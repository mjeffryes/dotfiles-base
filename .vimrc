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

call ucompleteme#Setup()

let g:syntastic_check_on_wq = 0

let g:ale_linters = {
    \ 'dart': ['language_server'],
\}

let g:ale_fixers = {
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

" autoformat when writting the buffer
augroup autoformatonwrite
  autocmd!
  autocmd BufWritePre * :Autoformat
augroup END

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

function! CGitPathToClipBoard()
  let cur_path = expand('%:p')
  let parts = split(cur_path, "workspace")
  let rel_path = parts[1]
  let rel_path_parts = split(rel_path, '/')
  let repo = rel_path_parts[0]
  let path = join(rel_path_parts[1:], '/')
  if repo == "source2"
    let repo = "source"
  endif
  let cg_path = "https://phabricator.twitter.biz/source/".repo."/browse/master/".path.";HEAD$".line('.')
  let @* = cg_path
  echo cg_path
endfunction

nnoremap <F7> :call CGitPathToClipBoard()<cr>
nnoremap <F6> :Dash<cr>
