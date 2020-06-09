" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'svermeulen/vim-macrobatics'
Plug 'tpope/vim-rails'
Plug 'neovim/node-host'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'stillwwater/vim-nebula'
Plug 'airblade/vim-gitgutter'
  " Let coc-git handle the signs, as they work in real time
  let g:gitgutter_signs = 0
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
Plug 'ap/vim-buftabline'
  let g:buftabline_show = 1
  let g:buftabline_numbers = 1
  let g:buftabline_indicators = 1

Plug 'ncm2/float-preview.nvim'
"
" Session
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'

" Git

Plug 'tpope/vim-fugitive'

" Auto completion, snippets and linting 
Plug 'unblevable/quick-scope'
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['black']
  let g:neoformat_enabled_ruby = ['rubocop']

Plug 'Shougo/neoinclude.vim'
Plug 'honza/vim-snippets'

" Navigation and editing
Plug 'SirVer/ultisnips'
Plug 'chaoren/vim-wordmotion'
Plug 'jonatan-branting/vim-which-key'
  let g:which_key_use_floating_win = 1
  let g:which_key_align_by_separator = 0
  let g:which_key_flatten = 1

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

" ---- Auto Commands (Pertaining to filetypes or plugins) ----
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

" ---- Remaps ----

" Macros using macrobatics
nmap <nowait> q <plug>(Mac_Play)
nmap <nowait> gq <plug>(Mac_RecordNew)

" coc.nvim popups
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "j"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "k"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call CocAction('doHover')<CR>
nnoremap gw :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
vnoremap gw :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

" Continue the CocList TODO disable gitgutter signs
nmap <Leader>c :CocListResume<CR>

" Lists

" Which-key 
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.Q = [':q!', 'force-quit']

" File jumping 
nnoremap <silent> <C-p> :CocList files -F<CR>
nnoremap <silent> <C-f> :CocList -I grep -F <CR>
nnoremap <silent> <C-e> :CocList buffers<CR>
nnoremap <silent> <Leader>p :CocList files -W<CR>
nnoremap <silent> <Leader>i :exe ':CocList files '. expand("%:p:h")<CR>
let g:which_key_map.i =  'files-from-cwd'
let g:which_key_map.p =  'files-from-workspace'
let g:which_key_map.e = [':Sexplore', 'file-explorer']

let g:which_key_map.r = {
      \'name': 'ruby',
      \'r': [':R', 'open-related'],
      \'a': [':A', 'open-alternate'],
      \'f': ['gf', 'goto-file-under-cursor'],
      \}

let g:which_key_map.w = { 
      \'name' : '+windows',
      \'w' : ['<C-W>w'     , 'other-window'],
      \'d' : ['<C-W>c'     , 'delete-window'],
      \'-' : ['<C-W>s'     , 'split-window-below'],
      \'|' : ['<C-W>v'     , 'split-window-right'],
      \'2' : ['<C-W>v'     , 'layout-double-columns'],
      \'h' : ['<C-W>h'     , 'window-left'],
      \'j' : ['<C-W>j'     , 'window-below'],
      \'l' : ['<C-W>l'     , 'window-right'],
      \'k' : ['<C-W>k'     , 'window-up'],
      \'H' : ['<C-W>5<'    , 'expand-window-left'],
      \'J' : [':resize +5'  , 'expand-window-below'],
      \'L' : ['<C-W>5>'    , 'expand-window-right'],
      \'K' : [':resize -5'  , 'expand-window-up'],
      \'=' : ['<C-W>='     , 'balance-window'],
      \'s' : ['<C-W>s'     , 'split-window-below'],
      \'v' : ['<C-W>v'     , 'split-window-below'],
      \}

let g:which_key_map.f = {
      \'name' : '+folding',
      \'a' : ['zR', 'open-all'],
      \'f' : ['zA', 'toggle'],
      \'c' : ['zc', 'close'],
      \'C' : ['zM', 'close-all'],
      \}

let g:which_key_map.l = {
      \'name' : '+Lists',
      \'f'  : [':CocList quickfix', 'quickfix'],
      \'w'  : [':CocList workspace', 'workspace'],
      \'k'  : [':CocList links', 'links'],
      \'s'  : [':CocList sessions', 'sessions'],
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

let g:which_key_map.a = {
      \'name' : '+Actions',
      \'x'  : ['<Plug>(coc-fix-current)',         'fix-line'],
      \'l'  : ['<Plug>(coc-codeaction)',          'codeaction-line'],
      \'s'  : ['<Plug>(coc-codeaction-selected)', 'codeaction-selected'],
      \'r'  : ['<Plug>(coc-rename)',              'rename'],
      \'f'  : [':Neoformat', 'format'],
      \'c'  : [':CocList commands', 'commands'],
      \'d'  : [':CocList diagnostics', 'diagnostics'],
      \}

let g:which_key_map.b = {
      \'name' : '+buffer',
      \'1' : ['b1'        , 'buffer 1'],
      \'2' : ['b2'        , 'buffer 2'],
      \'d' : ['bd'        , 'delete-buffer'],
      \'f' : ['bfirst'    , 'first-buffer'],
      \'h' : ['Startify'  , 'home-buffer'],
      \'l' : ['blast'     , 'last-buffer'],
      \'n' : ['bnext'     , 'next-buffer'],
      \'p' : ['bprevious' , 'previous-buffer'],
      \'b' : 'list-buffers', 
      \}


" git bindings
nmap <Leader>gl :call <SID>ListGitChanges()<CR>
nmap <Leader>ga :CocCommand git.diffCached<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gi <Plug>(coc-git-chunkinfo)
nmap <Leader>gs :CocCommand git.chunkStage<CR>
nmap <Leader>gu :CocCommand git.chunkUndo<CR>
nmap <Leader>go :CocCommand git.showCommit<CR>
nmap <Leader>gS :GStatus<CR>
nmap <Leader>gr :Git reset<CR>
let g:which_key_map.g = { 'name' : '+git',}
let g:which_key_map.g.l = 'list-git-diff'
let g:which_key_map.g.c = 'show-diff-cached'
let g:which_key_map.g.i = 'show-chunk-info'
let g:which_key_map.g.s = 'stage-chunk'
let g:which_key_map.g.S = 'fugitive-status'
let g:which_key_map.g.u = 'undo-chunk'
let g:which_key_map.g.r = 'git-soft-reset'
let g:which_key_map.g.o = 'show-commit-for-chunk'

" create text object for git chunks
omap ic <Plug>(coc-git-chunk-inner)
xmap ic <Plug>(coc-git-chunk-inner)
omap ac <Plug>(coc-git-chunk-outer)
xmap ac <Plug>(coc-git-chunk-outer)


" Register which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" ---- HELPER FUNCTIONS USED ABOVE ----

function! s:ListGitChanges()
  execute 'GitGutterQuickFix'
  execute 'CocList --number-select quickfix'
endfunction

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList -I grep '.word
endfunction

" ---- REMAPPING DEFAULTS ----

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

nnoremap <silent> <Left> :bprevious<CR>
nnoremap <silent> <Right> :bnext<CR>
tnoremap <silent> <Left> :bprevious<CR>
tnoremap <silent> <Right> :bnext<CR>


" --- Load other settings ---

runtime core-settings.vim
runtime colorscheme.vim
runtime statusline.vim
