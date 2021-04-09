let g:python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'
set shell=/bin/zsh

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
set lazyredraw
set backspace=indent,eol,start

" Visuals
set list
" set listchars=trail:\ ,nbsp:\ ,tab:>\ 
set fillchars+=vert:\|
set nocursorline
set relativenumber
set number

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
set background=light
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

" if has("nvim")
"   au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
"   au FileType fzf tunmap <buffer> <Esc>
" endif

au! FileType qf setlocal nonumber norelativenumber wrap
au! TermOpen * vert | setlocal nonumber norelativenumber | exec "normal! G"

nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
nnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
