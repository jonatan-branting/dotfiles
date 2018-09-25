" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "
" {{{
call plug#begin('~/.nvim/plugged')

" General purpose and libraries
" {{{
Plug 'terryma/vim-multiple-cursors'
Plug 'ap/vim-buftabline'
  let g:buftabline_show = 1
  let g:buftabline_numbers = 2
  let g:buftabline_indicators = 1
Plug 'tomtom/tlib_vim'
Plug 'neovim/node-host'
Plug 'junegunn/goyo.vim'
Plug 'Shougo/denite.nvim'
  nnoremap <silent> <Leader>l :Denite line<CR>
  nnoremap <silent> <C-p> :Denite file<CR>
  nnoremap <silent> <Leader>y :Denite neoyank<CR>

" Themes
" {{{

Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'dracula/vim'

" }}}

" Auto completion

Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
" {{{

  " Settings
  let g:deoplete#enable_at_startup = 1

  let g:deoplete#sources = {}
  let g:deoplete#sources.cpp = ['LanguageClient']
  let g:deoplete#sources.python = ['LanguageClient']
  let g:deoplete#sources.python3 = ['LanguageClient']
  let g:deoplete#sources.rust = ['LanguageClient']
  let g:deoplete#sources.c = ['LanguageClient']
  let g:deoplete#sources.vim = ['vim']

  " Manual complete
  inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()
  imap <C-@> <C-Space>

  " Keybinds
  inoremap <C-j> <C-n>
  inoremap <C-k> <C-p>
" }}}

Plug 'Shougo/echodoc'
let g:echodoc#enable_at_startup = 1
let g:echodoc#enable_force_overwrite = 1
Plug 'sbdchd/neoformat'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'wokalski/autocomplete-flow'
  let g:neosnippet#enable_completed_snippet = 1
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'python': ['pyls']
    \ }

let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_hoverPreview = "Never"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>


" File editing
" {{{
Plug 'junegunn/fzf'
Plug 'junegunn/vim-easy-align'
" {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
" }}}
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
" }}}

"Clang
"{{{
Plug 'zchee/deoplete-clang'
  let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
  let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
"}}}

call plug#end()
" }}}
"
"

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Filetype specific stuff
" {{{
autocmd FileType cpp nnoremap <Leader>b :w<CR> :!g++ -std=c++17 -pedantic -Wall -Wextra %
autocmd FileType cpp nnoremap <Leader>r :w<CR> :!g++ -std=c++17 -pedantic -Wall -Wextra %; ./a.out
au bufread *.py nnoremap <Leader>r :w<CR> :!python %<CR>
" }}}

" ---- Functions ----
"  {{{
function! Csc()
  cscope find c <cword>
  copen
endfunction
command! Csc call Csc()
" }}}

" ---- Vim random settings. ----
" {{{

" Fix defaults
" {{{
filetype on
filetype plugin indent on
syntax enable
set noshowmode
set completeopt-=preview
set scrolloff=15
set lazyredraw
set backspace=indent,eol,start
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap L $
noremap H ^
vnoremap < <gv
vnoremap > >gv
noremap vv 0v$
nnoremap V y$
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap <C-c> <Esc>
cmap w!! w !sudo tee % >/dev/null<CR>
" }}}

" Stuff
" {{{
set list
set listchars=tab:>.,trail:.,nbsp:.
set number
set relativenumber
set nowrap
set nocursorline
" }}}

" Indent rules
" {{{
set expandtab
set tabstop=4
set shiftwidth=2
set autoindent
set smarttab
set shiftround
" }}}

" Searing and case handling
" {{{
set smartcase
set ignorecase
set hlsearch
set incsearch
" }}}


" Terminal
" {{{
  tnoremap <Esc> <C-\><C-n>
  command Hst execute ":split term://fish"
  command Vst execute ":vsplit term://fish"
  command Ist execute ":term://fish"
" }}}

" Windows
" {{{
nnoremap <silent> <Leader>wj <C-w>j
nnoremap <silent> <Leader>wJ :split<CR>
nnoremap <silent> <Leader>wk <C-w>k
nnoremap <silent> <Leader>wh <C-w>h
nnoremap <silent> <Leader>wl <C-w>l
nnoremap <silent> <Leader>wL :vsplit<CR>
nnoremap <silent> <Leader>wd :q<CR>
nnoremap <silent> <Leader>ws :w<CR>
tnoremap <silent> <Left> :bp<CR>
tnoremap <silent> <C-Right> :bn<CR>
" }}}

" Buffers.
" {{{
set hidden
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bD :bd!<CR>
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bp :bprevious<CR>
nnoremap <Leader>bs :b
nnoremap <silent> <Leader>bb <C-6>
nnoremap <silent> <Leader>bl :Unite buffer<CR>
nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>
nnoremap <silent> <C-1> :b 1<CR>
nmap <Leader>1 <Plug>BufTabLine.Go(1)
nmap <Leader>2 <Plug>BufTabLine.Go(2)
nmap <Leader>3 <Plug>BufTabLine.Go(3)
nmap <Leader>4 <Plug>BufTabLine.Go(4)
nmap <Leader>5 <Plug>BufTabLine.Go(5)
nmap <Leader>6 <Plug>BufTabLine.Go(6)
nmap <Leader>7 <Plug>BufTabLine.Go(7)
nmap <Leader>8 <Plug>BufTabLine.Go(8)
nmap <Leader>9 <Plug>BufTabLine.Go(9)
" }}}

" History
" {{{
"set undofile
set history=10000
set undolevels=10000
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmenu
set wildmode=full
" }}}

" Folding
" {{{
set foldmethod=marker
"autocmd! FileType java, c, cpp, setlocal foldmethod=syntax
autocmd! FileType python setlocal foldmethod=indent
autocmd! BufWinEnter * normal zR
nnoremap <silent> <Leader>ff za
nnoremap <silent> <Leader>fr zA
nnoremap <silent> <Leader>fo zR
nnoremap <silent> <Leader>fc zM
nnoremap <silent> <Leader>fj zj
nnoremap <silent> <Leader>fk zk
" }}}

" Behaviour
" {{{
set visualbell
set shortmess+=I
set noerrorbells
map q: :q
set mouse=a
set nobackup
set noswapfile
set autochdir
au InsertLeave * set nopaste
" }}}

" Python
" {{{
let g:python_host_prog = '/home/nonah/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/nonah/.pyenv/versions/neovim3/bin/python'
nnoremap <Leader>mr :w <CR>!clear <CR>:!python % <CR>
" }}}

" Theme
" {{{
" Enable true color support 
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

set t_Co=256
set laststatus=0
set background=light
set showcmd
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
colo solarized
