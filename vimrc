
set encoding=utf-8
set nocompatible

let my_vimlib_path = $VIMUSERRUNTIME
if my_vimlib_path == ''
  let my_vimlib_path = '~/.vim'
endif
let my_plugin_cache_path = my_vimlib_path . '/caches/'
let $MYVIMLIBRARY = my_vimlib_path
if has('win32')
  let &viminfo = &viminfo . ',n' . my_vimlib_path . '/viminfo'
endif

" Start neobundle
filetype off
if has('vim_starting')
  set runtimepath^=$MYVIMLIBRARY/bundle/neobundle.vim/
endif
if has('win32')
  let g:neobundle#types#git#default_protocol = 'https'
endif
call neobundle#rc(expand(my_vimlib_path . '/bundle/'))

" Bundles
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
              \ 'build' : {
              \     'windows' : 'vcmake make_msvc32.mak',
              \     'cygwin' : 'make -f make_cygwin.mak',
              \     'mac' : 'make -f make_mac.mak',
              \     'unix' : 'make -f make_unix.mak',
              \    },
              \ }

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'ujihisa/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'dag/vim2hs'
NeoBundle 'oceandeep'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'godlygeek/tabular'
NeoBundle 'eagletmt/unite-haddock', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'ujihisa/unite-colorscheme', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'tsukkee/unite-tag', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'thinca/vim-unite-history', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'Shougo/vimfiler', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv', { 'depends': 'tpope/vim-fugitive' }
NeoBundle 'rygwdn/vim-conque'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'kana/vim-textobj-indent', { 'depends': 'kana/vim-textobj-user' }
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'bling/vim-airline'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'plasticboy/vim-markdown'

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

set completeopt-=preview
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

" NeoSnippet configuration
let g:neosnippet#snippets_directory = my_vimlib_path . '/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" neco-ghc configuration
let g:necoghc_enable_detailed_browse = 1

" Vim2hs configuration
let g:haskell_conceal_enumerations = 0

" Unite configuration
let g:unite_data_directory = my_plugin_cache_path . 'unite'
call unite#set_profile('', 'ignorecase', 1)
map <C-p> :call unite#start(['file_rec', '!'], { 'is_insert': 1 })<CR>

" Syntastic configuration (for now off by default)
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" VimFiler configuration
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = my_plugin_cache_path . 'vimfiler'

" dwm configuration
let g:dwm_map_keys = 0 " Some default keybindings suck
nnoremap <silent> <C-J> <C-W>w
nnoremap <silent> <C-K> <C-W>W
nnoremap <silent> <C-,> :call DWM_Rotate(0)<CR>
nnoremap <silent> <C-.> :call DWM_Rotate(1)<CR>

nnoremap <silent> <C-N> :call DWM_New()<CR>
nnoremap <silent> <C-Space> :call DWM_Focus()<CR>

" Airline configuration
let g:airline_theme='solarized'
let g:airline_detect_whitespace=0 "disabled

filetype plugin indent on

autocmd FileType c,cpp setlocal number cindent
autocmd FileType objc setlocal number cindent cinwords=if,else,while,do,for,switch,[
autocmd FileType haskell setlocal number autoindent
autocmd FileType mkd setlocal softtabstop=4 shiftwidth=4 autoindent linebreak nojoinspaces textwidth=80 formatoptions=tnaw
                                \ formatlistpat=^\\s*\\([*+-]\\\|\\((*\\d\\+[.)]\\+\\)\\\|\\((*\\l[.)]\\+\\)\\)\\s\\+
autocmd FileType mkd nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
autocmd FileType mkd let b:autopairs_loaded=1

