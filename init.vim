
" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'svermeulen/vim-macrobatics'
Plug 'ayu-theme/ayu-vim'
Plug 'neovim/node-host'
Plug 'stillwwater/vim-nebula'
Plug 'gillyb/stable-windows'
Plug 'skywind3000/asyncrun.vim'
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
Plug 'liuchengxu/vim-clap'
Plug 'reedes/vim-colors-pencil'
Plug 'ap/vim-buftabline'
  let g:buftabline_show = 1
  let g:buftabline_numbers = 1
  let g:buftabline_indicators = 1

" Plug 'ncm2/float-preview.nvim'
"
" Session
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'
  let g:session_autosave = 'no'

" Git
Plug 'kshenoy/vim-signature'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Auto completion, snippets and linting 
Plug 'unblevable/quick-scope'
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['black']
Plug 'Shougo/neoinclude.vim'
Plug 'honza/vim-snippets'

" Navigation and editing
Plug 'SirVer/ultisnips'
Plug 'chaoren/vim-wordmotion'
Plug 'jonatan-branting/vim-which-key'
Plug 'matze/vim-tex-fold'
Plug 'tmhedberg/SimpylFold'
Plug 'Shougo/neoyank.vim'
Plug 'tmsvg/pear-tree'
  let g:pear_tree_smart_closers = 1
  let g:pear_tree_smart_openers = 1
  let g:pear_tree_smart_backspace = 1
Plug 'junegunn/vim-easy-align'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'

" Themes
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dracula/vim'
call plug#end()

" ---- Auto Commands ----

autocmd FileType python,py nnoremap <Leader>p :term python %<CR>
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

augroup StatusLineHider()
  au! 
  au TermOpen * setl laststatus=0
  au BufWinEnter * if &filetype == 'list' | setlocal laststatus=0 | setlocal noruler | endif
  au BufWinLeave * if &filetype == 'list' | setlocal laststatus=2 | setlocal noruler | endif
augroup end


" ---- Settings ----


" Coc
let g:coc_explorer_global_presets = {   '.vim': {      'root-uri': '~/.vim',   },   'floating': {      'position': 'floating',   },   'floatingLeftside': {      'position': 'floating',      'floating-position': 'left-center',      'floating-width': 50,   },   'floatingRightside': {      'position': 'floating',      'floating-position': 'left-center',      'floating-width': 50,   },   'simplify': {     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'   } }

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

inoremap <C-S-f> <C-o>:CocList grep<CR> 
nnoremap <C-S-f> :CocList grep<CR>
inoremap <C-e> <C-o>:CocList buffers<CR>
nnoremap <C-e> :CocList buffers<CR>


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocAction('doHover')<CR>

" Lists
nmap ; :CocList buffers<CR>
nnoremap <silent> <C-p> :CocList mru<CR>

" nnoremap <Leader>y "+y
" nnoremap <Leader>p "+p
"

" Which-key
let g:which_key_use_floating_win = 1
let g:which_key_align_by_separator = 0
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.q = [':q', 'quit']
let g:which_key_map.Q = [':q!', 'force-quit']
let g:which_key_map.m = [':AsyncRun make', 'make']
let g:which_key_map.e = [':CocCommand explorer', 'file-explorer']

nnoremap qp <Plug>(Mac_Play)
nnoremap qr <Plug>(Mac_RecordNew)

let g:which_key_map.q = { 'name': "+Editing" }
let g:which_key_map.q.p = "play macro"
let g:which_key_map.q.r = "record macro"
let g:which_key_flatten = 1


" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_map.w = { 'name' : '+windows' , 'w' : ['<C-W>w'     , 'other-window']          , 'd' : ['<C-W>c'     , 'delete-window']         , '-' : ['<C-W>s'     , 'split-window-below']    , '|' : ['<C-W>v'     , 'split-window-right']    , '2' : ['<C-W>v'     , 'layout-double-columns'] , 'h' : ['<C-W>h'     , 'window-left']           , 'j' : ['<C-W>j'     , 'window-below']          , 'l' : ['<C-W>l'     , 'window-right']          , 'k' : ['<C-W>k'     , 'window-up']             , 'H' : ['<C-W>5<'    , 'expand-window-left']    , 'J' : ['resize +5'  , 'expand-window-below']   , 'L' : ['<C-W>5>'    , 'expand-window-right']   , 'K' : ['resize -5'  , 'expand-window-up']      , '=' : ['<C-W>='     , 'balance-window']        , 's' : ['<C-W>s'     , 'split-window-below']    , 'v' : ['<C-W>v'     , 'split-window-below']    , }

let g:which_key_map.f = {'name' : '+folding','a' : ['zR', 'open-all'],'f' : ['zA', 'toggle'],'c' : ['zc', 'close'],'C' : ['zM', 'close-all'],}

let g:which_key_map.l = {'name' : '+Project','q'  : [':CocList quickfix', 'quickfix'],'o'  : [':CocList grep', 'find-all-occurences'],'w'  : [':CocList workspace', 'workspace'],'k'  : [':CocList links', 'links'],'s'  : [':CocList service', 'service'],'l'  : [':CocList lines', 'lines'],}


let g:which_key_map.l = {'name' : '+Lists','e'  : [':CocList extensions', 'extensions'],'o'  : [':CocList outline', 'outline'],'w'  : [':CocList workspace', 'workspace'],'k'  : [':CocList links', 'links'],'s'  : [':CocList service', 'service'],'l'  : [':CocList lines', 'lines'],}

let g:which_key_map.c = {'name' : '+Actions','x'  : ['<Plug>(coc-fix-current)',         'fix-line'],'l'  : ['<Plug>(coc-codeaction)',          'codeaction-line'],'s'  : ['<Plug>(coc-codeaction-selected)', 'codeaction-selected'],'r'  : ['<Plug>(coc-rename)',              'rename'],'f'  : [':Neoformat', 'format'],'c'  : [':CocList commands', 'commands'],'d'  : [':CocList diagnostics', 'diagnostics']}

let g:which_key_map.b = { 'name' : '+buffer' , '1' : ['b1'        , 'buffer 1']        , '2' : ['b2'        , 'buffer 2']        , 'd' : ['bd'        , 'delete-buffer']   , 'f' : ['bfirst'    , 'first-buffer']    , 'h' : ['Startify'  , 'home-buffer']     , 'l' : ['blast'     , 'last-buffer']     , 'n' : ['bnext'     , 'next-buffer']     , 'p' : ['bprevious' , 'previous-buffer'] , 'b' : 'list-buffers'      , }


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

let g:which_key_map.v = { 'name' : '+git',}

nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>
tnoremap <silent> <Left> :bprevious<CR>
tnoremap <silent> <Right> :bnext<CR>

" Register which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Remapping defaults
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
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" --- Defaults ---
" Python hosts
let g:python_host_prog = '/home/nonah/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/nonah/.pyenv/versions/neovim3/bin/python'
nmap <silent> gr <Plug>(coc-references)
noremap <buffer> <F10> :exec '!python -m pdb' shellescape(@%, 1)<cr>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

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
" set fillchars+=vert:
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
set background=light
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
set showcmd


" Theme
syntax enable
let g:pencil_terminal_italics = 1
let g:pencil_spell_undercurl = 1
let g:pencil_gutter_color = 1 

let g:challenger_deep_termcolors = 16
colorscheme challenger_deep

hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE  ctermbg=NONE

" Fix challenger_deep color scheme
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
hi CursorLineNr guifg=#565575 guibg=None gui=NONE
" hi StatusLine guibg=#777799
hi Pmenu guibg=#363555

hi StatusLine guibg=#363555 guifg=#ffffff 
hi StatusLineNormal guibg=#363555 guifg=#ffffff 
hi PathColor guibg=#363555 guifg=#999999
hi StatusLineNC guibg=NONE guifg=NONE
hi StatusLineNC guibg=#363555 guifg=#ffffff 
hi SA guibg=#363555 guifg=#ffffff
hi SAred guibg=#363555 guifg=#ffffff
hi DiagnosticWarning guibg=#363555 guifg=#ffa500
hi DiagnosticError guibg=#363555 guifg=#ff3333
hi SAline guibg=#4a4b6a guifg=#8685a5
hi VertSplit ctermbg=NONE guibg=None guifg=#363555
hi BufTabLineFill ctermbg=NONE guibg=None
hi BufTabLineActive ctermbg=NONE guibg=None gui=italic
hi BufTabLineCurrent ctermbg=NONE guibg=None gui=bold
hi BufTabLineHidden ctermbg=NONE guibg=None


" StatusLine TODO move to separate file
set laststatus=2

function! Modified()
  return &modified ? " +" : ""
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


function! StatusDiagnosticErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '·' . info['error'])

  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return get(g:, 'coc_status', '')
endfunction

function! StatusDiagnosticWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '·' . info['warning'])
  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" function! s:RefreshStatus()
"   for nr in range(1, winnr('$'))
"     call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
"   endfor
" endfunction

" augroup status
"   autocmd!
"   autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
" augroup END

" Left
set statusline=%#SAline#
set statusline+=%{ColPadding()}
set statusline+=%{col('.')}\ 
set statusline+=%#StatusLineNormal#
set statusline+=\ ››\ 
set statusline+=%f 

" Modified-flag
set statusline+=%{Modified()}
set statusline+=\ ‹‹\ 
set statusline+=%#PathColor#
set statusline+=\ %F\ 

" Split
set statusline+=%= 

" Right
set statusline+=%#DiagnosticWarning#
set statusline+=%{StatusDiagnosticWarnings()}
set statusline+=\ 
set statusline+=%#DiagnosticError#
set statusline+=%{StatusDiagnosticErrors()}
set statusline+=%#SAline#
set statusline+=\ %{StatuslineGit()}
set statusline+=\ 

let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.vim/plugged')

a
" General purpose and libraries
Paslug 'svermeulen/vim-macrobatics'
Plug 'ayu-theme/ayu-vim'
Plug 'neovim/node-host'
Plug 'stillwwater/vim-nebula'
Plug 'gillyb/stable-windows'
Plug 'skywind3000/asyncrun.vim'
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
Plug 'liuchengxu/vim-clap'
Plug 'reedes/vim-colors-pencil'
Plug 'ap/vim-buftabline'
  let g:buftabline_show = 1
  let g:buftabline_numbers = 1
  let g:buftabline_indicators = 1

" Plug 'ncm2/float-preview.nvim'
"
" Session
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'
  let g:session_autosave = 'no'

" Git
Plug 'kshenoy/vim-signature'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Auto completion, snippets and linting 
Plug 'unblevable/quick-scope'
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['black']
Plug 'Shougo/neoinclude.vim'
Plug 'honza/vim-snippets'

" Navigation and editing
Plug 'SirVer/ultisnips'
Plug 'chaoren/vim-wordmotion'
Plug 'jonatan-branting/vim-which-key'
Plug 'matze/vim-tex-fold'
Plug 'tmhedberg/SimpylFold'
Plug 'Shougo/neoyank.vim'
Plug 'tmsvg/pear-tree'
  let g:pear_tree_smart_closers = 1
  let g:pear_tree_smart_openers = 1
  let g:pear_tree_smart_backspace = 1
Plug 'junegunn/vim-easy-align'
  vmap <Enter> <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
Plug 'wellle/targets.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'

" Themes
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dracula/vim'
call plug#end()

" ---- Auto Commands ----

autocmd FileType python,py nnoremap <Leader>p :term python %<CR>
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

augroup StatusLineHider()
  au! 
  au TermOpen * setl laststatus=0
  au BufWinEnter * if &filetype == 'list' | setlocal laststatus=0 | setlocal noruler | endif
  au BufWinLeave * if &filetype == 'list' | setlocal laststatus=2 | setlocal noruler | endif
augroup end


" ---- Settings ----


" Coc
let g:coc_explorer_global_presets = {
    \   '.vim': {
    \      'root-uri': '~/.vim',
    \   },
    \   'floating': {
    \      'position': 'floating',
    \   },
    \   'floatingLeftside': {
    \      'position': 'floating',
    \      'floating-position': 'left-center',
    \      'floating-width': 50,
    \   },
    \   'floatingRightside': {
    \      'position': 'floating',
    \      'floating-position': 'left-center',
    \      'floating-width': 50,
    \   },
    \   'simplify': {
    \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
    \   }
    \ }

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

inoremap <C-S-f> <C-o>:CocList grep<CR> 
nnoremap <C-S-f> :CocList grep<CR>
inoremap <C-e> <C-o>:CocList buffers<CR>
nnoremap <C-e> :CocList buffers<CR>


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocAction('doHover')<CR>

" Lists
nmap ; :CocList buffers<CR>
nnoremap <silent> <C-p> :CocList mru<CR>

" nnoremap <Leader>y "+y
" nnoremap <Leader>p "+p
"

" Which-key
let g:which_key_use_floating_win = 1
let g:which_key_align_by_separator = 0
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.q = [':q', 'quit']
let g:which_key_map.Q = [':q!', 'force-quit']
let g:which_key_map.m = [':AsyncRun make', 'make']
let g:which_key_map.e = [':CocCommand explorer', 'file-explorer']

nnoremap qp <Plug>(Mac_Play)
nnoremap qr <Plug>(Mac_RecordNew)

let g:which_key_map.q = { 'name': "+Editing" }
let g:which_key_map.q.p = "play macro"
let g:which_key_map.q.r = "record macro"
let g:which_key_flatten = 1


" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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
      \'name' : '+Project',
      \'q'  : [':CocList quickfix', 'quickfix'],
      \'o'  : [':CocList grep', 'find-all-occurences'],
      \'w'  : [':CocList workspace', 'workspace'],
      \'k'  : [':CocList links', 'links'],
      \'s'  : [':CocList service', 'service'],
      \'l'  : [':CocList lines', 'lines'],
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

let g:which_key_map.v = {
      \ 'name' : '+git',
      \}

nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>
tnoremap <silent> <Left> :bprevious<CR>
tnoremap <silent> <Right> :bnext<CR>

" Register which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Remapping defaults
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
" set fillchars+=vert:
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
set background=light
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
set showcmd


" Theme
syntax enable
let g:pencil_terminal_italics = 1
let g:pencil_spell_undercurl = 1
let g:pencil_gutter_color = 1 

let g:challenger_deep_termcolors = 16
colorscheme challenger_deep

hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE  ctermbg=NONE

" Fix challenger_deep color scheme
hi LineNr guibg=NONE  ctermbg=NONE
hi pythonString gui=italic guifg=#ffe9aa
hi CursorLineNr guifg=#565575 guibg=None gui=NONE
" hi StatusLine guibg=#777799
hi Pmenu guibg=#363555

hi StatusLine guibg=#363555 guifg=#ffffff 
hi StatusLineNormal guibg=#363555 guifg=#ffffff 
hi PathColor guibg=#363555 guifg=#999999
hi StatusLineNC guibg=NONE guifg=NONE
hi StatusLineNC guibg=#363555 guifg=#ffffff 
hi SA guibg=#363555 guifg=#ffffff
hi SAred guibg=#363555 guifg=#ffffff
hi DiagnosticWarning guibg=#363555 guifg=#ffa500
hi DiagnosticError guibg=#363555 guifg=#ff3333
hi SAline guibg=#4a4b6a guifg=#8685a5
hi VertSplit ctermbg=NONE guibg=None guifg=#363555
hi BufTabLineFill ctermbg=NONE guibg=None
hi BufTabLineActive ctermbg=NONE guibg=None gui=italic
hi BufTabLineCurrent ctermbg=NONE guibg=None gui=bold
hi BufTabLineHidden ctermbg=NONE guibg=None


" StatusLine TODO move to separate file
set laststatus=2

function! Modified()
  return &modified ? " +" : ""
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


function! StatusDiagnosticErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '·' . info['error'])

  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return get(g:, 'coc_status', '')
endfunction

function! StatusDiagnosticWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '·' . info['warning'])
  endif
  if empty(msgs)
    return ''
  endif
  return join(msgs, ' '). ' '
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" function! s:RefreshStatus()
"   for nr in range(1, winnr('$'))
"     call setwinvar(nr, '&statusline', '%!Status(' . nr . ')')
"   endfor
" endfunction

" augroup status
"   autocmd!
"   autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatus()
" augroup END

" Left
set statusline=%#SAline#
set statusline+=%{ColPadding()}
set statusline+=%{col('.')}\ 
set statusline+=%#StatusLineNormal#
set statusline+=\ ››\ 
set statusline+=%f 

" Modified-flag
set statusline+=%{Modified()}
set statusline+=\ ‹‹\ 
set statusline+=%#PathColor#
set statusline+=\ %F\ 

" Split
set statusline+=%= 

" Right
set statusline+=%#DiagnosticWarning#
set statusline+=%{StatusDiagnosticWarnings()}
set statusline+=\ 
set statusline+=%#DiagnosticError#
set statusline+=%{StatusDiagnosticErrors()}
set statusline+=%#SAline#
set statusline+=\ %{StatuslineGit()}
set statusline+=\ 
