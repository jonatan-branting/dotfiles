" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"
" TODO
" 1. submodes for windows and chunks
" 2. Fix the statusbar (Changes when not in focus, etc.)
" 3. Better usage of CocNext, etc. + quickfix

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'svermeulen/vim-macrobatics'
Plug 'justinmk/vim-sneak'
  let g:sneak#label = 1
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-projectionist'
Plug 'neovim/node-host'
Plug 'tpope/vim-dispatch'
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
Plug 'dhruvasagar/vim-zoom'

" UI
Plug 'ap/vim-buftabline'
  let g:buftabline_show = 1
  let g:buftabline_numbers = 1
  let g:buftabline_indicators = 1

" Session
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-session'
  let g:session_autoload = 'no'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_signs = 0

" Auto completion, snippets and linting 
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'ncm2/float-preview.nvim'
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

" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

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
      \'/' : ['<C-W>v'     , 'split-window-right'],
      \'2' : ['<C-W>v'     , 'layout-double-columns'],
      \'h' : ['<C-W>h'     , 'window-left'],
      \'j' : ['<C-W>j'     , 'window-below'],
      \' ' : ['<C-W>m'     , 'zoom-current-window'],
      \'l' : ['<C-W>l'     , 'window-right'],
      \'k' : ['<C-W>k'     , 'window-up'],
      \'H' : ['<C-W>5<'    , 'expand-window-left'],
      \'y' : ['<C-W>H'     , 'flip-layout'],
      \'J' : [':resize +5' , 'expand-window-below'],
      \'L' : ['<C-W>5>'    , 'expand-window-right'],
      \'K' : [':resize -5' , 'expand-window-up'],
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
      \'e'  : [':CocList extensions', 'extensions'],
      \'s'  : [':CocList sessions', 'sessions'],
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
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gm :Git mergetool<CR>
nmap <Leader>gd :Git diff<CR>
let g:which_key_map.g = { 'name' : '+git',}
let g:which_key_map.g.s = 'git-status'
let g:which_key_map.g.c = 'git-commit'
let g:which_key_map.g.m = 'git-merge'

nmap <Leader>hs :CocCommand git.chunkStage<CR>
nmap <Leader>hu :CocCommand git.chunkUndo<CR>
nmap <Leader>hl :call <SID>ListGitChanges()<CR>
nmap <Leader>hb :CocCommand git.showCommit<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
let g:which_key_map.h = { 'name' : '+hunks',}
let g:which_key_map.h.u = 'undo-chunk'
let g:which_key_map.h.l = 'list-git-diff'
let g:which_key_map.h.s = 'stage-chunk'
let g:which_key_map.h.b = 'show-blame-info'
let g:which_key_map.h.n = 'next-chunk'
let g:which_key_map.h.p = 'prev-chunk'

" create text object for git chunks
omap ic <Plug>(coc-git-chunk-inner)
xmap ic <Plug>(coc-git-chunk-inner)
omap ac <Plug>(coc-git-chunk-outer)
xmap ac <Plug>(coc-git-chunk-outer)

" show chunkinfo easily
nmap gh <Plug>(coc-git-chunkinfo)


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

" --- Load other settings ---

runtime core-settings.vim
runtime colorscheme.vim
runtime statusline.vim
