" TODO add more fold keybinds
" TODO learn fugitive better
" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "
" {{{
call plug#begin('~/.vim/plugged')

" General purpose and libraries
Plug 'tomtom/tlib_vim'

" LaTeX
Plug 'lervag/vimtex'

" File editing
" {{{
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
" {{{
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
" }}}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'wellle/targets.vim'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
" {{{
  let g:UltiSnipsExpandTrigger="<tab>"
" }}}
" }}}

" Git
Plug 'tpope/vim-fugitive'
" {{{
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'
  nnoremap <silent> <Leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <Leader>gc :Gcommit<CR>
  nnoremap <silent> <Leader>gb :Gblame<CR>
  nnoremap <silent> <Leader>ge :Gedit<CR>
  nnoremap <silent> <Leader>gE :Gedit<space>
  nnoremap <silent> <Leader>gr :Gread<CR>
  nnoremap <silent> <Leader>gR :Gread<space>
  nnoremap <silent> <Leader>gw :Gwrite<CR>
  nnoremap <silent> <Leader>gW :Gwrite!<CR>
  nnoremap <silent> <Leader>gq :Gwq<CR>
  nnoremap <silent> <Leader>gQ :Gwq!<CR>
" }}}

" File navigation
" {{{
Plug 'ap/vim-buftabline'
Plug 'mhinz/vim-startify'
Plug 'Shougo/unite.vim'
" {{{
  let g:unite_source_history_yank_enable = 1
  let g:unite_enable_auto_select = 0
  let g:unite_prompt = ': '
  autocmd FileType unite imap <buffer> <ESC> <Plug>(unite_exit)
  autocmd FileType unite imap <buffer> <Tab> <Plug>(unite_select_next_line)
  nnoremap <silent> <Leader><space> :Unite file<CR>
" }}}
" }}}

" Autocompletion and code checking
" {{{
Plug 'honza/vim-snippets'
"Plug 'scrooloose/syntastic'
Plug 'benekastah/neomake'
" {{{
  let g:neomake_error_sign = {
        \ 'text' : 'e',
        \ 'texthl' : 'WarningMsg'
        \ }
  let g:neomake_warning_sign = {
        \ 'text' : 'w',
        \ 'texthl' : 'Normal'
        \ }

  let g:neomake_verbose = -1
  nnoremap <silent> <Leader>ml :Neomake<CR>
  autocmd! BufEnter,BufWritePost *.py silent! Neomake
" }}}
Plug 'Shougo/deoplete.nvim'
" {{{
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  inoremap <C-j> <C-n>
  inoremap <C-k> <C-p>
  let g:echodoc_enable_at_startup = 1
" }}}
Plug 'Shougo/echodoc.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
" }}}

"Python
" {{{
Plug 'fs111/pydoc.vim',              { 'for' : 'python'}
Plug 'lambdalisue/vim-pyenv',        { 'for' : 'python'}
Plug 'zchee/deoplete-jedi',          { 'for' : 'python'}
Plug 'hynek/vim-python-pep8-indent', { 'for' : 'python'}
" }}}

" Themes
" {{{
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
" {{{
  let g:lightline = {
        \ 'colorscheme' : 'PaperColor',
        \ 'active' : {
        \     'left' : [ 
        \                 ['mode', 'paste '],
        \                 [ 'fugitive', 'readonly', 'filename', 'modified']
        \             ],
        \     'right' :[
        \                 ['neomake', 'lineinfo'],
        \                 ['percent'],
        \                 ['filetype'],
        \                 ['pyenv']
        \             ]
        \ },
        \ 'component_function' : {
        \     'fugitive' : 'LLFugitive',
        \     'readonly' : 'LLReadOnly',
        \     'filename' : 'LLFilename',
        \     'modified' : 'LLModified',
        \     'neomake'  : 'LLNeomake',
        \     'pyenv'    : 'LLPyenv',
        \     'filetype' : 'LLFiletype'
        \ },
        \ 'subseparator' : { 'left' : '|', 'right': '|'}
        \}

  function! LLFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function LLReadOnly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
  endfunction

  function LLModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function LLFilename()
    return expand('%:t')
  endfunction

  function LLNeomake()
    return neomake#statusline#QflistStatus()
  endfunction

  function LLPyenv()
    return $PYENV_VERSION =~ 'system' ? '' : $PYENV_VERSION
  endfunction

  function LLFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction
" }}}

call plug#end()
" }}}
" }}}

" ---- After plug#end (call commands) -----
" {{{
" Unite
call unite#custom#profile('default', 'context', {
        \ 'start_insert' : 1,
        \ 'direction' : 'dynamicbottom',
        \ 'winheight' : '8',
        \ 'matchers'  : 'matcher_fuzzy'
        \ })
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
set cursorline
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
" }}}

" Buffers.
" {{{
set hidden
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <silent> <Leader>bn :bnext<CR>
nnoremap <silent> <Leader>bp :bprevious<CR>
nnoremap <Leader>bs :b 
nnoremap <silent> <Leader>bb <C-6>
nnoremap <silent> <Leader>bl :Unite buffer<CR>
" }}}

" History
" {{{
set undofile
set history=10000
set undolevels=10000
set wildignore=*.swp,*.bak,*.pyc,*.class
set wildmenu
set wildmode=full
" }}}

" Folding
" {{{
set foldmethod=marker
autocmd FileType java, c, cpp, setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
autocmd BufWinEnter * normal zR
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
set t_Co=256
set laststatus=2
set background=light
set showcmd
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
colorscheme PaperColor
" }}}
