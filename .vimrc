" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "
" {{{
call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'tomtom/tlib_vim'
Plug 'neovim/node-host'
Plug 'tpope/vim-dispatch'

Plug 'junegunn/goyo.vim'

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
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'unblevable/quick-scope'
Plug 'wellle/targets.vim'
Plug 'honza/vim-snippets'

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
Plug 'Shougo/unite.vim'
" {{{
  let g:unite_source_history_yank_enable = 1
  let g:unite_enable_auto_select = 0
  let g:unite_prompt = ': '
  autocmd! FileType unite imap <buffer> <ESC> <Plug>(unite_exit)
  autocmd! FileType unite imap <buffer> <Tab> <Plug>(unite_select_next_line)
  nnoremap <silent> <Leader><space> :UniteWithBufferDir file<CR>
" }}}
" }}}

" Autocompletion and code checking
" {{{
Plug 'honza/vim-snippets'
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
  let g:neomake_logfile = "/home/nonah/neomake_log"
  nnoremap <silent> <Leader>ml :Neomake<CR>
  autocmd! BufEnter,BufWritePost *.py silent! Neomake


  " call pylint using the current python (venv or global)
  let g:neomake_python_venvpylint_maker = {
      \ 'exe': 'python $(which pylint)',
      \ 'args': [
          \ '-f', 'text',
          \ '-E',
          \ '--msg-template="{path}:{line}:{column}:{C}: [{symbol}] {msg}"',
          \ '-r', 'n'
      \ ],
      \ 'errorformat':
          \ '%A%f:%l:%c:%t: %m,' .
          \ '%A%f:%l: %m,' .
          \ '%A%f:(%l): %m,' .
          \ '%-Z%p^%.%#,' .
          \ '%-G%.%#',
      \ }


  let g:neomake_cpp_clang_maker = {
            \ 'args': ['-fsyntax-only', '-std=c++1z', '-Wall', '-Wextra', '-pedantic'],
            \ 'errorformat':
            \ '%-G%f:%s:,' .
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ '%f:%l:%c: %m,'.
            \ '%f:%l: %trror: %m,'.
            \ '%f:%l: %tarning: %m,'.
            \ '%f:%l: %m',
            \ }

  let g:neomake_cpp_clangtidy_maker = {
            \ 'exe': 'clang-tidy',
            \ 'args': ['--checks="modernize-*,readability-*,misc-*,clang-analyzer-*"'],
            \ 'errorformat':
            \ '%E%f:%l:%c: fatal error: %m,' .
            \ '%E%f:%l:%c: error: %m,' .
            \ '%W%f:%l:%c: warning: %m,' .
            \ '%-G%\m%\%%(LLVM ERROR:%\|No compilation database found%\)%\@!%.%#,' .
            \ '%E%m',
            \ }

  let g:neomake_cpp_enabled_makers = ['clang', 'clangtidy']
  "autocmd! BufWritePost * Neomake

" }}}
Plug 'Shougo/deoplete.nvim'
" {{{

  " Settings
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_refresh_always = 0
  let g:deoplete#enable_debug = 1
  let g:deoplete#max_list = 200

  " Manual complete
  inoremap <silent><expr> <C-Space> deoplete#mappings#manual_complete()
  imap <C-@> <C-Space>

  " Keybinds
  inoremap <C-j> <C-n>
  inoremap <C-k> <C-p>
" }}}
Plug 'Shougo/echodoc.vim'
" {{{
  let g:echodoc_enable_at_startup = 1
" }}}
Plug 'luochen1990/rainbow'
"{{{
  let g:rainbow_active = 1
  let g:rainbow_conf = {
  \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
  \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \   'operators': '_,_',
  \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \   'separately': {
  \       '*': {},
  \       'tex': {
  \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
  \       },
  \       'lisp': {
  \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
  \       },
  \       'vim': {
  \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
  \       },
  \       'html': {
  \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
  \       },
  \       'css': 0,
  \   }
  \}
"}}}
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-commentary'
" {{{
" }}}
" }}}
"
"Clang
Plug 'zchee/deoplete-clang'
"{{{
  let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
  let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'
"}}}
Plug 'Shougo/neoinclude.vim'
"Clojure
"{{{
"Plug 'hkupty/acid.nvim', { 'for' : 'clojure'} 
Plug 'tpope/vim-salve', { 'for' : 'clojure'}
Plug 'snoe/clj-refactor.nvim', { 'for' : 'clojure'}
Plug 'tpope/vim-classpath', { 'for' : 'clojure'}
Plug 'guns/vim-sexp', { 'for' : 'clojure'}
nnoremap <Leader>r :w<CR>:Require<CR>
" {{{
"let g:sexp_enable_insert_mode_mappings = 0
" }}}
"Plug 'snoe/nvim-parinfer.js', { 'for' : 'clojure'}
Plug 'clojure-vim/async-clj-omni', { 'for' : 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" {{{
  let g:deoplete#keyword_patterns = {}
  let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
" }}}

"}}}

"Python
" {{{
Plug 'fs111/pydoc.vim',                               { 'for' : 'python'}
Plug 'lambdalisue/vim-pyenv',                         { 'for' : 'python'}
Plug 'zchee/deoplete-jedi', {'for' : 'python'}
" {{{
  let g:deoplete#sources#jedi#show_docstring = 1
" }}}
Plug 'hynek/vim-python-pep8-indent',                  { 'for' : 'python'}
" }}}

" Themes
" {{{
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'robertmeta/nofrils'
Plug 'taohex/lightline-buffer'
Plug 'itchyny/lightline.vim'
" {{{
  let g:lightline = {
        \ 'tabline': {
        \ 'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
        \ 'right': [ ],
        \ },
        \ 'component_expand': {
        \ 'buffercurrent': 'lightline#buffer#buffercurrent2',
        \ },
        \ 'component_type': {
        \ 'buffercurrent': 'tabsel',
        \ },
        \ 'colorscheme' : 'hybrid',
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
        \ 'bufferbefore': 'lightline#buffer#bufferbefore',
        \ 'bufferafter': 'lightline#buffer#bufferafter',
        \ 'bufferinfo': 'lightline#buffer#bufferinfo',
        \     'fugitive' : 'LLFugitive',
        \     'readonly' : 'LLReadOnly',
        \     'filename' : 'LLFilename',
        \     'modified' : 'LLModified',
        \     'neomake'  : 'LLNeomake',
        \     'pyenv'    : 'LLPyenv',
        \     'filetype' : 'LLFiletype'
        \ },
        \ 'separator': { 'left': "", 'right': "" },
        \ 'subseparator': { 'left': "", 'right': "" }
        \}

  function! LLFugitive()
    return exists('*fugitive#head') ? fugitive#head() : ''
  endfunction

  function LLReadOnly()
  return &ft !~? 'help' && &readonly ? '⭤' : ''
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

" ---- Functions ----
function! Csc()
  cscope find c <cword>
  copen
endfunction
command! Csc call Csc()


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


" Terminal
tnoremap <Esc> <C-\><C-n>

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
set t_Co=256
set laststatus=2
set showtabline=2
set background=dark
set showcmd
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
" }}}
