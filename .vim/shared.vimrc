set nocompatible

set re=0 "disable painfully slow regex based syntax highlighting

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

set clipboard=unnamed

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
