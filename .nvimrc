" ---- Enable plugins. ----

call plug#begin('~/.nvim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tlib_vim'
Plug 'kien/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'honza/vim-snippets'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-projectionist', { 'for': 'clojure' }
Plug 'tpope/vim-leiningen', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
call plug#end()

" ---- Plugin settings. ----

" YCM.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = "/home/nonah/.vim/.ycm_extra_conf.py"
let g:ycm_min_num_identifier_candidate_chars = 0
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_collect_identifiers_from_tags_files = 1
set tags+=./.tags
nnoremap <C-c> :YcmCompleter GoToDefinitionElseDeclaration<CR>
noremap <C-e> :YcmDiag<CR>

" VimFiler.
map <silent> <C-n> :VimFiler -buffer-name=explorer -split -simple -winwidth=37 -toggle -no-quit<CR>

" UltiSnips.
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"
let g:UltiSnipsExpandTrigger="<tab>"

" Syntastic.
nmap <C-k> :SyntasticToggleMode<CR>

" CtrlP.
noremap <silent> <C-b> :CtrlPBuffer<CR>

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" DelimitMate
autocmd BufNewFile,BufRead *.clj :DelimitMateOff

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

" Aethestics.
set t_Co=256
colorscheme genericdc-light
set laststatus=2
set background=light

" Buffers.
set hidden

" Keybindings.
noremap j gj
noremap k gk
noremap L $
noremap H 0
vnoremap < <gv
vnoremap > >gv

" Commands
command Nt execute "!urxvtc -cd $(pwd)"

" No backup.
set nobackup
set noswapfile

" Mouse
set mouse=a

" Keybindings.
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap { {<CR>}<Esc>ko
inoremap <C-c> <Esc>
nmap t o<ESC>k
nmap T O<ESC>j

" Pasting.
au InsertLeave * set nopaste

" Python.
map <F5> :w <CR>!clear <CR>:!python % <CR>

" Editing a protected file as 'sudo'
cmap w!! w !sudo tee % >/dev/null<CR>
