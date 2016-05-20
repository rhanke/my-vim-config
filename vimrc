
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

" Check for dein install
if empty(globpath(my_vimlib_path, '/plugins/repos/github.com/Shougo/dein.vim'))
  if !executable('git')
    echoerr "Need 'git' installed"
  endif
  let install_path = my_vimlib_path . '/plugins/repos/github.com/Shougo/dein.vim'
  call system('git clone https://github.com/Shougo/dein.vim "' . install_path . '"')
endif

" Start dein
set runtimepath^=$MYVIMLIBRARY/plugins/repos/github.com/Shougo/dein.vim
call dein#begin(expand(my_vimlib_path . '/plugins/'))

" Bundles
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc', {
              \ 'build' : {
              \     'windows' : 'tools\\update-dll-mingw',
              \     'cygwin' : 'make -f make_cygwin.mak',
              \     'mac' : 'make -f make_mac.mak',
              \     'unix' : 'make -f make_unix.mak',
              \    },
              \ })

" Completion
call dein#add('Shougo/neocomplete')
call dein#add('cohama/lexima.vim')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets', { 'depends': 'ultisnips' })

" Editing and formatting
call dein#add('tomtom/tcomment_vim')
call dein#add('junegunn/vim-easy-align')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-indent', { 'depends': 'vim-textobj-user' })

" Navigation
call dein#add('easymotion/vim-easymotion')
call dein#add('bkad/CamelCaseMotion')

" Unite
call dein#add('Shougo/unite.vim')
call dein#add('eagletmt/unite-haddock', { 'depends': 'unite.vim' })
call dein#add('ujihisa/unite-colorscheme', { 'depends': 'unite.vim' })
call dein#add('tsukkee/unite-tag', { 'depends': 'unite.vim' })
call dein#add('thinca/vim-unite-history', { 'depends': 'unite.vim' })
call dein#add('osyo-manga/unite-quickfix', { 'depends': 'unite.vim' })
call dein#add('Shougo/vimfiler', { 'depends': 'unite.vim' })
call dein#add('Shougo/neomru.vim', { 'depends': 'unite.vim' })

" Document / project structure
call dein#add('vim-ctrlspace/vim-ctrlspace')
call dein#add('vim-voom/VOoM')

" Haskell
call dein#add('eagletmt/neco-ghc', { 'external_commands': 'ghc-mod' })
call dein#add('eagletmt/ghcmod-vim', { 'external_commands': 'ghc-mod' })
call dein#add('neovimhaskell/haskell-vim')

" Source control
call dein#add('tpope/vim-fugitive')
call dein#add('gregsexton/gitv', { 'depends': 'vim-fugitive' })

" Markdown & writing
call dein#add('vim-pandoc/vim-pandoc')
call dein#add('vim-pandoc/vim-pandoc-syntax')
call dein#add('reedes/vim-pencil')

" Colorschemes
call dein#add('chriskempson/base16-vim')
call dein#add('altercation/vim-colors-solarized')
call dein#add('oceandeep')

" User interface
call dein#add('mbbill/undotree')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('junegunn/goyo.vim')
call dein#add('ruedigerha/vim-fullscreen', { 'gui': 1 })

call dein#end()

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

set background=dark
set termguicolors
colorscheme base16-ocean

syntax on
let mapleader=' '

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

" ghcmod-vim configuration
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" Unite configuration
let g:unite_data_directory = my_plugin_cache_path . 'unite'
call unite#custom#profile('default', 'context', {
\       'ignorecase': 1
\     })

" Easy Align configuration
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" VimFiler configuration
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_data_directory = my_plugin_cache_path . 'vimfiler'

" Airline configuration
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1   " for CtrlSpace
let g:airline#extensions#whitespace#enabled = 0

" vim-pandoc configuration
let g:pandoc#modules#disabled = ['folding', 'chdir']

" vim-pandoc-syntax configuration
let g:pandoc#syntax#codeblocks#embeds#langs = ['cpp', 'haskell', 'swift']
let g:pandoc#syntax#conceal#urls = 1

" vim-pencil configuration
let g:pencil#conceallevel = 2

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

" Keybindings for Quickfix List navigation
nmap <silent> <leader>cc :cc<CR>
nmap <silent> <leader>cj :cnext<CR>
nmap <silent> <leader>ck :cprevious<CR>
nmap <silent> <leader>cq :cclose<CR>

" Keybindings for Location List navigation
nmap <silent> <leader>ll :ll<CR>
nmap <silent> <leader>lj :lnext<CR>
nmap <silent> <leader>lk :lprevious<CR>
nmap <silent> <leader>lq :lclose<CR>

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

autocmd FileType c,cpp setlocal number cindent undofile
autocmd FileType objc setlocal number cindent cinwords=if,else,while,do,for,switch,[
autocmd FileType haskell setlocal number autoindent undofile
autocmd FileType pandoc call pencil#init({'conceallevel': 2})
autocmd FileType pandoc setlocal softtabstop=4 shiftwidth=4 autoindent linebreak nojoinspaces undofile
if has("mac")
  autocmd FileType pandoc nnoremap <buffer> <leader>m :silent !open -a 'Marked 2.app' '%:p'<cr>
endif

