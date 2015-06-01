" Necessary settings for plugins.
let mapleader=","

" ---- Enable plugins. ----

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tlib_vim'
Plug 'kien/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'honza/vim-snippets'
Plug 'Shougo/unite.vim'
Plug 'lervag/vim-latex'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'SirVer/ultisnips'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tacahiroy/ctrlp-funky'
Plug 'justinmk/vim-sneak'
Plug 'mbbill/undotree'
Plug 'oblitum/YouCompleteMe'
Plug 'itchyny/lightline.vim'
Plug 'dgrnbrg/vim-redl'
"Plug 'Valloric/YouCompleteMe'
"Plug 'ludovicchabant/vim-gutentags'
call plug#end()

" ---- Plugin settings. ----

" YCM.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_min_num_of_chars_for_completion = 99
let g:ycm_disable_for_files_larger_than_kb = 2000
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_cache_omnifunc = 0
set tags+=./.tags
nnoremap <Leader>i :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <C-e> :YcmDiag<CR>

" VimFiler.
map <silent> <C-n> :VimFiler -buffer-name=explorer -split -simple -winwidth=24 -toggle -no-quit<CR>

" Syntastic.
nmap <C-k> :SyntasticToggleMode<CR>

" CtrlP.
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <C-h> :CtrlPMRU<CR>
nnoremap <silent> <C-f> :CtrlPFunky<CR>
let g:ctrl_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
    \ --ignore "**/*.pyc"
  \ -g ""'

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" DelimitMate
"autocmd BufNewFile,BufRead *.clj :DelimitMateOff

" Sneak
let g:sneak#streak = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

" UndoTree
nnoremap <silent> <Leader>u :UndotreeToggle<CR>

" Eclim
let g:EclimCompletionMethod = 'omnifunc'

" Fireplace
nnoremap <Leader>re :Require! <bar> %Eval<CR>

" ---- Vim random settings. ----
" Random.
filetype plugin indent on
syntax enable
set shortmess+=I
set relativenumber
set nowrap
set cursorline
set number
set expandtab
set tabstop=4
set shiftwidth=2
set backspace=indent,eol,start
set autoindent
set shiftround
set showmatch
set smartcase
set ignorecase
set smarttab
set hlsearch
set incsearch
set scrolloff=5
autocmd filetype python set expandtab
set completeopt-=preview
set lazyredraw
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P

" Aethestics.k
set t_Co=256
set laststatus=2
set background=dark

" Buffers.
set hidden

" Keybindings.
noremap j gj
noremap k gk
noremap L $
noremap H 0
vnoremap < <gv
vnoremap > >gv
inoremap jj <Esc>

" No backup.
set nobackup
set noswapfile

" Mouse
set mouse=a

" Keybindings.
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap <C-c> <Esc>
nnoremap <silent> <Leader>ws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Pasting.
au InsertLeave * set nopaste

" Python.
map <F5> :w <CR>!clear <CR>:!python % <CR>

" Editing a protected file as 'sudo'
cmap w!! w !sudo tee % >/dev/null<CR>

let g:gruvbox_italic=1
colorscheme gruvbox
