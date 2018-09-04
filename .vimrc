"--------------------------------------------------------------------------
" neobundle
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'scrooloose/nerdtree'
call neobundle#end()

filetype plugin indent on     " Required!

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif


"------------------------------
""" basic
"------------------------------
colorscheme desert
syntax on

set verbose=0
set encoding=utf-8

set number
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
map <F4> :set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%<CR><Esc>
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" remove spaces at line end
au BufWritePre * :%s/\s\+$//ge

"------------------------------
""" indent
"------------------------------
set autoindent
set expandtab
filetype plugin indent on
