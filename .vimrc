" Necessary settings for plugins. (Before they load)
let mapleader=","

" ---- Enable plugins. ----

call plug#begin('~/.vim/plugged')

" General purpose and libraries
Plug 'Shougo/unite.vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-dispatch'

" Text editing
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'

" File editing
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'radenling/vim-dispatch-neovim'

" File navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'Shougo/vimfiler.vim'

" Autocompletion and code checking
Plug 'honza/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'justinmk/vim-sneak'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'Valloric/YouCompleteMe'

" Clojure
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'dgrnbrg/vim-redl', { 'for': 'clojure '}

" Themes
Plug 'jscappini/material.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
"Plug 'bling/vim-airline'
call plug#end()

" ---- Plugin settings. ----

" YCM.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_disable_for_files_larger_than_kb = 2000
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_cache_omnifunc = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_cache_omnifunc = 0
let g:ycm_filetype_blacklist = {
  \ 'python' : 1
  \}
set tags+=./.tags
nnoremap <Leader>i :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <C-e> :YcmDiag<CR>

" VimFiler.
map <silent> <C-n> :VimFiler -buffer-name=explorer -split -simple -winwidth=24 -toggle -no-quit<CR>

" CtrlP.
nnoremap <silent> <C-b> :CtrlPBuffer<CR>
nnoremap <silent> <C-h> :CtrlPMRU<CR>
nnoremap <silent> <C-f> :CtrlPFunky<CR>
let g:ctrlp_working_path_mode = 'ca'
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
autocmd BufNewFile,BufRead *.clj :DelimitMateOff

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

" Eclim
let g:EclimCompletionMethod = 'omnifunc'

" Fireplace
nnoremap <Leader>re :Require! <bar> %Eval<CR>

" ---- Vim random settings. ----

" Enable filetype detection and indention
filetype on
filetype plugin indent on
syntax enable

" Hightlight whitespace
set list
set listchars=tab:>.,trail:.,nbsp:.

" Disable start message
set shortmess+=I

" Set relative number
set number
set relativenumber

" Disable linewrapping cause it's ugly
set nowrap
set cursorline

" Indent rules
set expandtab
set tabstop=4
set shiftwidth=2
set autoindent
set smarttab
set shiftround

" Searing and case handling
set smartcase
set ignorecase
set hlsearch
set incsearch

" QoL
set backspace=indent,eol,start

" Disable completion preview window
set completeopt-=preview

" Draw options
set scrolloff=5
set lazyredraw

" Aethestics

" Buffers.
set hidden

" Keybindings.
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap L $
noremap H 0
vnoremap < <gv
vnoremap > >gv
inoremap jj <Esc>
noremap vv 0v$
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap <C-c> <Esc>
nnoremap <silent> <Leader>ws :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <F5> :w <CR>!clear <CR>:!python % <CR>
cmap w!! w !sudo tee % >/dev/null<CR>

" History 
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class

" Don't sound annoying
set visualbell
set noerrorbells

" No backup.
set nobackup
set noswapfile

" Behaviour
set mouse=a
au InsertLeave * set nopaste

" Theme
set t_Co=256
set laststatus=2
set background=light
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
let g:lightline = { 'colorscheme': 'PaperColor'}
