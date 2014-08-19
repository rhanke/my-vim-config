
set encoding=utf-8
set nocompatible

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
filetype off
if has('vim_starting')
  set runtimepath^=$MYVIMLIBRARY/bundle/neobundle.vim/
endif
if has('win32')
  let g:neobundle#types#git#default_protocol = 'https'
endif
call neobundle#rc(expand(my_vimlib_path . '/bundle/'))

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
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'dag/vim2hs'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'oceandeep'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'junegunn/vim-easy-align'
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
NeoBundle 'szw/vim-ctrlspace'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'vim-voom/VOoM'

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
let mapleader='-'

" NeoComplete configuration
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#data_directory = my_plugin_cache_path . 'neocomplete'

" neco-ghc configuration
let g:necoghc_enable_detailed_browse = 1

" Vim2hs configuration
let g:haskell_conceal_enumerations = 0

" Unite configuration
let g:unite_data_directory = my_plugin_cache_path . 'unite'
call unite#set_profile('', 'ignorecase', 1)

" Easy Align configuration
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" Syntastic configuration (for now off by default)
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['haskell'],
                           \ 'passive_filetypes': [] }
let g:syntastic_aggregate_errors = 1

" VimFiler configuration
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = my_plugin_cache_path . 'vimfiler'

" Airline configuration
let g:airline_detect_whitespace = 0 " disabled
let g:airline_powerline_fonts = !has('win32')
let g:airline_exclude_preview = 1   " for CtrlSpace

" vim-markdown configuration
let g:vim_markdown_folding_disabled=1

" CtrlSpace configuration
let g:ctrlspace_project_root_markers = [".git", ".cabal-sandbox", ".svn"]
let g:ctrlspace_cache_dir = my_plugin_cache_path . 'ctrlspace'
if finddir(g:ctrlspace_cache_dir) == ""
  call mkdir(g:ctrlspace_cache_dir)
endif
let g:ctrlspace_ignored_files = '\v(tmp|temp|dist|build)[\/]'
let g:ctrlspace_use_ruby_bindings = has("ruby")
let g:ctrlspace_unicode_font = !has("win32")
if executable("ag")
  let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
endif
function s:adjust_ctrlspace_colors()
  let css = airline#themes#get_highlight('CursorLine')
  exe "hi CtrlSpaceStatus guibg=" . css[1]
endfunction

autocmd ColorScheme * call s:adjust_ctrlspace_colors()

" Keybindings for Haskell
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hi :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :GhcModTypeClear<CR>

" Keybindings for Unite
nmap <silent> <leader>uh :Unite -start-insert hoogle<CR>
nmap <silent> <leader>ud :Unite -start-insert haddock<CR>
nmap <silent> <leader>uc :Unite history/command<CR>
nmap <silent> <leader>us :Unite history/search<CR>
let g:unite_source_history_yank_enable = 1
nmap <silent> <leader>uy :Unite history/yank<CR>

filetype plugin indent on

autocmd FileType c,cpp setlocal number cindent
autocmd FileType objc setlocal number cindent cinwords=if,else,while,do,for,switch,[
autocmd FileType haskell setlocal number autoindent
autocmd FileType mkd setlocal softtabstop=4 shiftwidth=4 autoindent linebreak nojoinspaces textwidth=80 formatoptions=tnaw
                                \ formatlistpat=^\\s*\\([*+-]\\\|\\((*\\d\\+[.)]\\+\\)\\\|\\((*\\l[.)]\\+\\)\\)\\s\\+
autocmd FileType mkd nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
autocmd FileType mkd let b:autopairs_loaded=1

