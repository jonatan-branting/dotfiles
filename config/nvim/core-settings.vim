let g:python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'
set shell=fish

" Fix general stuff
autocmd FileType json syntax match Comment +\/\/.\+$+
filetype on
filetype plugin on
filetype plugin indent on
set noshowmode
set completeopt-=preview
" set completeopt=menuone,noselect
set updatetime=300
set shortmess+=c
set scrolloff=7
set nolazyredraw
set backspace=indent,eol,start

" Visuals
set list
" set listchars=trail:\ ,nbsp:\ ,tab:>\ 
set fillchars+=vert:\|
set nocursorline
set relativenumber
set number
set pumblend=10

" Indent rules
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set smarttab

" Searing and case handling
set smartcase
set ignorecase
set hlsearch
set incsearch

" History
set history=10000
set undolevels=10000
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmenu
set undodir=~/.nvim/undo-dir
set undofile
set wildmode=full

" Behaviour
set hidden
" set signcolumn=yes
set foldmethod=manual
set visualbell
set shortmess+=I
set noerrorbells
set clipboard=unnamedplus
map q: :q
set mouse=a
set nobackup
set noswapfile
au InsertLeave * set nopaste


" Theme
set termguicolors
set t_Co=256
set noshowmode
set shortmess+=c
" set signcolumn=yes
set termguicolors
set timeoutlen=500
set cmdheight=1
set linebreak
set breakindent
set autoindent
set guioptions+=k
set guioptions-=L
set guioptions-=r
set laststatus=2
set showcmd


" Enable local .nvimrc's
set exrc
set secure

" Remapping default keybindings
vnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'
