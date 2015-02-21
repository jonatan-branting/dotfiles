" Do this first.
set nocompatible

" Plugins
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
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'vim-scripts/paredit.vim', { 'for': 'clojure' }
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'

call plug#end()

" Syntax and numbering, etc.
filetype plugin indent on
syntax enable
set shortmess+=I
set background=light
set relativenumber
set nowrap
set cursorline
set number

" Buffers
set hidden

set t_Co=256
colorscheme genericdc-light

" Keybindings.
noremap j gj
noremap k gk
noremap L $
noremap H 0
vnoremap < <gv
vnoremap > >gtsv
noremap <silent> <C-b> :CtrlPBuffer<CR>

" Tabs.
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

" No backup.
set nobackup
set noswapfile

" Mouse
set mouse=a

noremap <C-e> :YcmDiag<CR>

" Pasting.
au InsertLeave * set nopaste

" Blank lines without insert mode.
nmap t o<ESC>k
nmap T O<ESC>j

" Python.
map <F5> :w <CR>!clear <CR>:!python % <CR>
" Editing a protected file as 'sudo'
cmap w!! w !sudo tee % >/dev/null<CR>

" Statusline.
set laststatus=2

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"

" YCM
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

" Explore
map <silent> <C-n> :VimFiler -buffer-name=explorer -split -simple -winwidth=37 -toggle -no-quit<CR>

" Syntastic
nmap <C-k> :SyntasticToggleMode<CR>

" Ultisnips expand on enter!
let g:UltiSnipsExpandTrigger = "<nop>"
inoremap <expr> <CR> pumvisible() ? "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>" : "\<CR>"

" INSERT MODE KEYBINDS
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0

" FIX
inoremap { {<CR>}<Esc>ko
inoremap <C-c> <Esc>
