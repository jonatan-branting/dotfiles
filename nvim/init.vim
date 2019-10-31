" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
" Plug 'cohama/lexima.vim'

" Plug 'rbong/vim-crystalline'
" Plug 'vim-airline/vim-airline'
Plug 'kassio/neoterm'
Plug 'dhruvasagar/vim-zoom'
Plug 'rhysd/git-messenger.vim'
" Plug 'tmsvg/pear-tree'
"   let g:pear_tree_smart_openers = 1
"   let g:pear_tree_smart_closers = 1
"   let g:pear_tree_smart_backspace = 1
" Plug 'itchyny/lightline.vim'
" Plug 'KangOl/vim-pudb'
Plug 'vim-airline/vim-airline-themes'
"Plug 'soywod/kronos.vim'
"Plug 'junegunn/goyo.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'skywind3000/asyncrun.vim'
Plug 'mhinz/vim-startify'
Plug 'tomtom/tlib_vim'
Plug 'neovim/node-host'
Plug 'tpope/vim-fugitive'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'
  let g:session_autosave = 'no'
Plug 'xolox/vim-misc'
" Plug 'rstacruz/vim-closer'
Plug 'chaoren/vim-wordmotion'
Plug 'liuchengxu/vim-which-key'

" Themes
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'arcticicestudio/nord-vim'
  let g:nord_italic = 1
Plug 'dracula/vim'
Plug 'mhartington/oceanic-next'
Plug 'reedes/vim-colors-pencil'
Plug 'rakr/vim-two-firewatch'
Plug 'ayu-theme/ayu-vim'
Plug 'xero/blaquemagick.vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'kaicataldo/material.vim'

" Language specific
Plug 'sheerun/vim-polyglot'
  let g:polyglot_disabled = ['latex']
Plug 'matze/vim-tex-fold'
Plug 'tmhedberg/SimpylFold'
" Plug 'lervag/vimtex'
  " let g:vimtex_compiler_progname = 'pdflatex'
  " let g:tex_flavor='latex'
  " let g:vimtex_view_method='evince'
  " let g:vimtex_quickfix_mode=0
  " let g:tex_conceal='abdmg'
Plug 'mhinz/neovim-remote'
Plug 'prabirshrestha/async.vim'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-neco'
Plug 'neoclide/coc-pyls'
Plug 'slashmili/alchemist.vim'
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['black']
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
  let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"

Plug 'honza/vim-snippets'
Plug 'Shougo/neco-vim'
Plug 'pearofducks/ansible-vim'

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
Plug 'terryma/vim-multiple-cursors'


call plug#end()

" ---- Auto Commands ----

autocmd FileType python,py nnoremap <Leader>p :term python %<CR>
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

augroup StatusLineHider()
  au! 
  au TermOpen * setl laststatus=0
  au BufWinEnter * if &filetype == 'list' | set laststatus=0 | set noruler | endif
  au BufWinLeave * if &filetype == 'list' | set laststatus=2 | set noruler | endif
augroup end

augroup vimrc
  au!
  au BufWritePost init.vim,.vimrc so $MYVIMRC
augroup end

" augroup winpossave
"   au BufLeave * let b:winview = winsaveview()
"   au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
" augroup end

" ---- Settings ----

" Coc
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
nmap ; :CocList buffers<CR>
nnoremap <silent> <C-f> :CocList -I symbols<CR>
nnoremap <silent> <C-p> :CocList files<CR>

" Which-key
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.q = [':q', 'quit']
let g:which_key_map.Q = [':q!', 'force-quit']
let g:which_key_map.m = [':AsyncRun make', 'make']
let g:which_key_map.z = [':Goyo', 'goyo']

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
      \ }

let g:which_key_map.f = {
      \'name' : '+folding',
      \'a' : ['zR', 'open-all'],
      \'f' : ['zA', 'toggle'],
      \'c' : ['zc', 'close'],
      \'C' : ['zM', 'close-all'],
      \}


let g:which_key_map.l = {
      \'name' : '+Lists',
      \'e'  : [':CocList extensions', 'extensions'],
      \'o'  : [':CocList outline', 'outline'],
      \'w'  : [':CocList workspace', 'workspace'],
      \'k'  : [':CocList links', 'links'],
      \'s'  : [':CocList service', 'service'],
      \'l'  : [':CocList lines', 'lines'],
      \}

let g:which_key_map.c = {
      \'name' : '+Actions',
      \'x'  : ['<Plug>(coc-fix-current)',         'fix-line'],
      \'l'  : ['<Plug>(coc-codeaction)',          'codeaction-line'],
      \'s'  : ['<Plug>(coc-codeaction-selected)', 'codeaction-selected'],
      \'r'  : ['<Plug>(coc-rename)',              'rename'],
      \'f'  : [':Neoformat', 'format'],
      \'c'  : [':CocList commands', 'commands'],
      \'d'  : [':CocList diagnostics', 'diagnostics']
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
      \ 'b' : 'list-buffers'      ,
      \ }

" Fugitive git bindings #TODO which-key-ify these
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
" tnoremap <silent> <Left> :bprevious<CR>
" tnoremap <silent> <Right> :bnext<CR>

" Register which-key
let g:which_key_use_floating_win=1
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Remapping defaults
nnoremap <tab> }
nnoremap <s-tab> {
nnoremap ö {
nnoremap ä }
tnoremap <Esc> <C-\><C-n>
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>
nnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <silent><expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent><expr> j (v:count == 0 ? 'gj' : 'j')
inoremap jj <Esc>
noremap L g$
nnoremap X vaw
vnoremap H g^
vnoremap L g$
nnoremap , ;
noremap H g^
vnoremap < <gv
vnoremap > >gv
noremap vv 0v$
nnoremap Y y$
inoremap <C-l> <C-o>$
inoremap <C-h> <C-o>0
inoremap <C-c> <Esc>

" Get highlight group under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" --- Defaults ---
" Python hosts
let g:python_host_prog = '/home/nonah/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/nonah/.pyenv/versions/neovim3/bin/python'

" Fix general stuff
autocmd FileType json syntax match Comment +\/\/.\+$+
filetype on
filetype plugin on
filetype plugin indent on
set noshowmode
set completeopt-=preview
set scrolloff=7
set lazyredraw
set backspace=indent,eol,start


" Visuals
set list
set listchars=trail:\ ,nbsp:\ ,tab:>\ 
set nocursorline
set relativenumber
set number

" Indent rules
set expandtab
set tabstop=4
set shiftwidth=4
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
set signcolumn=yes
set foldmethod=manual
set visualbell
set shortmess+=I
set noerrorbells
map q: :q
set mouse=a
set nobackup
set noswapfile
set autochdir
au InsertLeave * set nopaste


" Theme
set termguicolors
set t_Co=256
set fillchars+=vert:\ 
set background=light
set showcmd
set noshowmode
set shortmess+=c
set signcolumn=yes
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


" Theme
syntax enable
color challenger_deep

" hi Normal guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE  ctermbg=NONE

" Fix challenger_deep color scheme
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
hi CursorLineNr guifg=#565575 guibg=None gui=NONE
" hi StatusLine guibg=#777799
hi Pmenu guibg=#363555

hi StatusLine guibg=#363555 guifg=#ffffff gui=italic
hi SA guibg=#363555 guifg=#ffffff
hi SAred guibg=#363555 guifg=#ff9494
hi SAline guibg=#4a4b6a guifg=#8685a5
" hi PMenu guibg=#4a4b6a guifg=#ffffff
" hi SAline guibg=#1e1c31 guifg=#8685a5
" guibg=#100e23
" guifg=#565575


" StatusLine
set laststatus=2

function! Modified()
  return &modified ? "+" : " "
endfunction

function! StatuslineGit()
  let line = fugitive#head()
  return strlen(line) > 0 ? line : "source"
endfunction

function! ColPadding()
  let l:pad = ""
  while len(l:pad) <= len(line('$')) - len(col('.')) + 1
    let l:pad .= " " 
  endwhile
  return l:pad
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

autocmd vimrc User CocOpenFloat
\  if !exists('w:popup')
\|   let t:last_signature_help = win_getid()
\| endif

autocmd vimrc CompleteChanged *
\  if exists('t:last_signature_help')
\|   if nvim_win_is_valid(t:last_signature_help)
\|     call nvim_win_close(t:last_signature_help, v:false)
\|   endif
\|   unlet t:last_signature_help
\| endif


" Left
set statusline=%#SAline#
set statusline+=%{ColPadding()}
set statusline+=%{col('.')}\ 
set statusline+=%#SA#
set statusline+=\ »\ 
set statusline+=%#StatusLine#
set statusline+=%f 

" Modified-flag
set statusline+=%#SA#
set statusline+=\ «\ 
set statusline+=%#SAred#
set statusline+=\ %{Modified()}\ 

" Split
set statusline+=%= 

" Right
set statusline+=%#SA#
" set statusline+=%{StatusDiagnostic()}
set statusline+=⟵\ 
set statusline+=%#StatusLine#
set statusline+=\ %{StatuslineGit()}
set statusline+=\ 
