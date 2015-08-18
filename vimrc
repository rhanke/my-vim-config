
set encoding=utf-8
set nocompatible
if has("mac")
  language de_DE.UTF-8
endif

let my_vimlib_path = $VIMUSERRUNTIME
if my_vimlib_path == ''
  let my_vimlib_path = $HOME . '/.vim'
endif
let my_plugin_cache_path = my_vimlib_path . '/caches/'
let $MYVIMLIBRARY = my_vimlib_path
if has('win32')
  let &viminfo = &viminfo . ',n' . my_vimlib_path . '/viminfo'
endif

" Start neobundle
if has('vim_starting')
  set runtimepath^=$MYVIMLIBRARY/bundle/neobundle.vim/
endif
if has('win32')
  let g:neobundle#types#git#default_protocol = 'https'
endif
call neobundle#begin(expand(my_vimlib_path . '/bundle/'))

" Bundles
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
              \ 'build' : {
              \     'windows' : 'tools\\update-dll-mingw',
              \     'cygwin' : 'make -f make_cygwin.mak',
              \     'mac' : 'make -f make_mac.mak',
              \     'unix' : 'make -f make_unix.mak',
              \    },
              \ }

NeoBundle 'Shougo/neocomplete'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets', { 'depends': 'SirVer/ultisnips' }
NeoBundle 'eagletmt/neco-ghc', { 'external_commands': 'ghc-mod' }
NeoBundle 'eagletmt/ghcmod-vim', { 'external_commands': 'ghc-mod' }
NeoBundle 'neovimhaskell/haskell-vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'mbbill/undotree'
NeoBundle 'oceandeep'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'eagletmt/unite-haddock', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'ujihisa/unite-colorscheme', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'tsukkee/unite-tag', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'thinca/vim-unite-history', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'osyo-manga/unite-quickfix', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'Shougo/vimfiler', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'Shougo/neomru.vim', { 'depends': 'Shougo/unite.vim' }
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv', { 'depends': 'tpope/vim-fugitive' }
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'kana/vim-textobj-indent', { 'depends': 'kana/vim-textobj-user' }
NeoBundle 'bkad/CamelCaseMotion'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'vim-voom/VOoM'
NeoBundle 'ruedigerha/vim-fullscreen', { 'gui': 1 }

call neobundle#end()

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
set hidden
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
set mouse=a

" Persistent undo
let &undodir = my_plugin_cache_path . 'undo'
if finddir(&undodir) == ''
  call mkdir(&undodir)
endif

" Base16 colors
if !has('gui_running')
  let g:base16_shell_path = '~/.config/base16-shell'
  if finddir(g:base16_shell_path) == ''
    unlet g:base16_shell_path
  else
    let base16colorspace=256
  endif
endif

set background=dark
colorscheme base16-ocean

syntax on
let mapleader='-'

" NeoComplete configuration
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#data_directory = my_plugin_cache_path . 'neocomplete'

" neomru configuration
let g:neomru#file_mru_path = my_plugin_cache_path . 'neomru/file'
let g:neomru#directory_mru_path = my_plugin_cache_path . 'neomru/directory'

" neco-ghc configuration
let g:necoghc_enable_detailed_browse = 1

" haskell-vim configuration
let g:haskell_enable_quantification = 1

" Unite configuration
let g:unite_data_directory = my_plugin_cache_path . 'unite'
call unite#custom#profile('default', 'context', {
\       'ignorecase': 1
\     })

" Easy Align configuration
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Syntastic configuration (for now off by default)
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['haskell'],
                           \ 'passive_filetypes': [] }
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0

" VimFiler configuration
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = my_plugin_cache_path . 'vimfiler'

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1   " for CtrlSpace
let g:airline#extensions#whitespace#enabled = 0

" vim-markdown configuration
let g:vim_markdown_folding_disabled=1

" Lexima rules
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#add_rule({'filetype': 'haskell', 'char': '-', 'at': '{\%#}', 'input': '-', 'input_after': '-'})
call lexima#add_rule({'filetype': 'haskell', 'char': '#', 'at': '{-\%#-}', 'input': '#', 'input_after': '#'})
call lexima#add_rule({'filetype': 'haskell', 'char': '<Space>', 'at': '{-#\?\%##\?-}', 'input': ' ', 'input_after': ' '})
call lexima#add_rule({'filetype': 'haskell', 'char': '<BS>', 'at': '{-#\?\%##\?-}', 'input': '<BS>', 'delete': 1})

" CtrlSpace configuration
let g:CtrlSpaceCacheDir = my_plugin_cache_path . 'ctrlspace'
if finddir(g:CtrlSpaceCacheDir) == ""
  call mkdir(g:CtrlSpaceCacheDir)
endif
let g:CtrlSpaceIgnoredFiles = '\v(tmp|temp|dist|build)[\/]'
if executable("ag")
  let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

" Keybindings for Haskell
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hi :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :GhcModTypeClear<CR>

" Keybinding for Undotree
nmap <silent> <leader>z :UndotreeToggle<CR>

" Keybindings for Unite
nmap <silent> <leader>uh :Unite -start-insert hoogle<CR>
nmap <silent> <leader>ud :Unite -start-insert haddock<CR>
nmap <silent> <leader>ul :Unite -winheight=10 -direction=botright location_list<CR>
nmap <silent> <leader>uq :Unite -winheight=10 -direction=botright quickfix<CR>
nmap <silent> <leader>ur :Unite file_mru<CR>
nmap <silent> <leader>uc :Unite history/command<CR>
nmap <silent> <leader>us :Unite history/search<CR>
let g:unite_source_history_yank_enable = 1
nmap <silent> <leader>uy :Unite history/yank<CR>

filetype plugin indent on

NeoBundleCheck

autocmd FileType c,cpp setlocal number cindent undofile
autocmd FileType objc setlocal number cindent cinwords=if,else,while,do,for,switch,[
autocmd FileType haskell setlocal number autoindent undofile
autocmd FileType mkd setlocal softtabstop=4 shiftwidth=4 autoindent linebreak nojoinspaces textwidth=80 formatoptions=tnaw undofile
autocmd FileType mkd nnoremap <leader>m :silent !open -a 'Marked 2.app' '%:p'<cr>

