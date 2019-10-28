" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
"
Plug 'justinmk/vim-sneak'
  let g:sneak#label = 1
  let g:sneak#next = 1
Plug 'skywind3000/asyncrun.vim'
  let g:asyncrun_open = 8
Plug 'mhinz/vim-startify'
Plug 'tomtom/tlib_vim'
Plug 'neovim/node-host'
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'
Plug 'xolox/vim-misc'
Plug 'rstacruz/vim-closer'
Plug 'chaoren/vim-wordmotion'
Plug 'liuchengxu/vim-which-key'
Plug 'Shougo/denite.nvim'

" Themes
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'arcticicestudio/nord-vim'
  let g:nord_italic = 1
Plug 'dracula/vim'

" Language specific
" Plug 'numirias/semshi'
Plug 'lervag/vimtex'
  let g:vimtex_compiler_progname = 'nvr'
  let g:tex_flavor='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_quickfix_mode=0
  " set conceallevel=1
  let g:tex_conceal='abdmg'
Plug 'mhinz/neovim-remote'
Plug 'gabrielelana/vim-markdown'
Plug 'prabirshrestha/async.vim'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
Plug 'neoclide/coc-denite'
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc-pyls'
Plug 'slashmili/alchemist.vim'
" Plug 'sbdchd/neoformat'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsJumpForwardTrigger = '<tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
Plug 'honza/vim-snippets'

Plug 'Shougo/neco-vim'
Plug 'pearofducks/ansible-vim'
Plug 'ambv/black'

" File editing
Plug 'junegunn/vim-easy-align'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'Shougo/echodoc'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
" Plug 'terryma/vim-multiple-cursors'


call plug#end()

" ---- Auto Commands ----

" TODO how do you actually do autocommands for a certain filetype?
" augroup latex
"   " autocmd BufEnter * CocDisable
"   setlocal spell
"   set spelllang=en
"   autocmd BufWrite * AsyncRun make
"   inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" augroup end


" ---- Settings ----

" Bind completion to tab

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction


inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocAction('doHover')<CR>

" Lists
nnoremap <silent> <Leader>ll :Denite line<CR>
nnoremap <silent> <C-p> :Denite file<CR>
nnoremap <silent> <C-b> :Denite buffer<CR>

" Save
nnoremap <silent> <Leader>s :w<CR>
nnoremap <silent> <Leader>x :x<CR>
nnoremap <silent> <Leader>q :q<CR>

nnoremap <silent> <Leader>m :AsyncRun make<CR>

" Which-key and keybindings

autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_use_floating_win = 0
let g:which_key_map = {}
let g:which_key_map.s = 'save'
let g:which_key_map.x = 'save-exit'
let g:which_key_map.q = 'quit'
let g:which_key_map.m = 'make'

" TODO Diagnostics

let g:which_key_map.w = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

let g:which_key_map.f = {
      \'name' : '+folding',
      \'a' : ['zR', 'open-all'],
      \'o' : ['zA', 'open'],
      \'c' : ['zc', 'close'],
      \'C' : ['zM', 'close-all'],
      \}

nnoremap <Leader>le :Denite coc-extension<CR>
nnoremap <Leader>lo :Denite coc-symbols<CR>
nnoremap <Leader>lw :Denite coc-workspace<CR>
nnoremap <Leader>ld :Denite coc-diagnostic<CR>
nnoremap <Leader>lc :Denite coc-command<CR>
nnoremap <Leader>lk :Denite coc-link<CR>
nnoremap <Leader>ls :Denite coc-service<CR>
nnoremap <Leader>b? :Denite buffer<CR>

let g:which_key_map.l = {
      \'name' : '+Lists',
      \'e'  : 'extensions',
      \'o'  : 'symbols',
      \'w'  : 'workspace',
      \'d'  : 'diagnostics',
      \'c'  : 'commands',
      \'k'  : 'links',
      \'s'  : 'service',
      \'l'  : 'lines',
      \}

let g:which_key_map.c = {
      \'name' : '+Actions',
      \'x'  : ['<Plug>(coc-fix-current)',         'fix-line'],
      \'l'  : ['<Plug>(coc-codeaction)',          'codeaction-line'],
      \'s'  : ['<Plug>(coc-codeaction-selected)', 'codeaction-selected'],
      \'r'  : ['<Plug>(coc-rename)',              'rename'],
      \'f'  : ['Black',                           'format-black'],
      \}


let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : 'list-buffers'      ,
      \ }

" fugitive git bindings
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
nnoremap <space>gc :Gcommit -v -q<CR>
nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
nnoremap <space>ge :Gedit<CR>
nnoremap <space>gr :Gread<CR>
nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
nnoremap <space>gps :Dispatch! git push<CR>
nnoremap <space>gpl :Dispatch! git pull<CR>

let g:which_key_map.g = {
      \ 'name' : '+git',
      \}

nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>

" Register which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Status line
"
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

"" Defaults

" Fix general stuff
autocmd FileType json syntax match Comment +\/\/.\+$+
filetype on
filetype plugin indent on
syntax enable
set noshowmode
set completeopt-=preview
" set scrolloff=8
set lazyredraw
set backspace=indent,eol,start
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
inoremap jj <Esc>
noremap L $
noremap H ^
vnoremap < <gv
vnoremap > >gv
noremap vv 0v$
nnoremap V y$
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap <C-c> <Esc>

" Stuff
set list
set listchars=trail:.,nbsp:.
set number
set relativenumber
set nowrap
set nocursorline

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
set signcolumn=yes
set foldmethod=syntax
set visualbell
set shortmess+=I
set noerrorbells
map q: :q
set mouse=a
set nobackup
set noswapfile
set autochdir
au InsertLeave * set nopaste

" Python hosts
let g:python_host_prog = '/home/nonah/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/nonah/.pyenv/versions/neovim3/bin/python'
" set shell=/bin/sh


" Theme

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
set fillchars+=vert:\ 
set background=dark
set showcmd
set noshowmode
set shortmess+=c
set signcolumn=yes
set termguicolors
set timeoutlen=500
set cmdheight=1
set linebreak
set breakindent
set wrap
" set showbreak=_

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
colo dracula
