
set encoding=utf-8

let my_vimlib_path = '~/.vim'
let my_plugin_cache_path = my_vimlib_path . '/caches/'
let $MYVIMLIBRARY = my_vimlib_path

" Start neobundle
set nocompatible
filetype off
if has('vim_starting')
  set runtimepath^=$MYVIMLIBRARY/bundle/neobundle.vim/
endif
call neobundle#rc(expand(my_vimlib_path . '/bundle/'))

" Bundles
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
              \ 'build' : {
              \     'windows' : 'echo "https://github.com/Shougo/vimproc/downloads"',
              \     'cygwin' : 'make -f make_cygwin.mak',
              \     'mac' : 'make -f make_mac.mak',
              \     'unix' : 'make -f make_unix.mak',
              \    },
              \ }

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'oceandeep'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'dag/vim2hs'
NeoBundle 'godlygeek/tabular'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'eagletmt/unite-haddock'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rygwdn/vim-conque'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'wlangstroth/vim-racket'
NeoBundle 'thinca/vim-unite-history'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Lokaltog/vim-powerline'

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set ruler
set laststatus=2
set nowrap
set splitright
set foldlevel=5
set hlsearch
set incsearch
set wildmenu
set virtualedit=block

syntax on
let mapleader=','

" NeoComplCache configuration
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_temporary_dir = my_plugin_cache_path . 'neocon'

" NeoComplCache-Snippets configuration
let g:neocomplcache_snippets_dir = my_vimlib_path . '/snippets'
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" Vim2hs configuration
let g:haskell_conceal_enumerations = 0

" Unite configuration
let g:unite_data_directory = my_plugin_cache_path . 'unite'
call unite#set_profile('', 'ignorecase', 1)
map <C-p> :call unite#start(['file_rec', '!'], { 's_insert': 1 })<CR>

" Syntastic configuration (for now off by default)
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" VimFiler configuration
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = my_plugin_cache_path . 'vimfiler'

filetype plugin indent on

autocmd FileType c,cpp setlocal number cindent
autocmd FileType objc setlocal number cindent cinwords=if,else,while,do,for,switch,[
autocmd FileType haskell setlocal number autoindent
autocmd FileType racket setlocal number

