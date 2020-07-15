" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"
let maplocalleader=','


" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'svermeulen/vim-macrobatics'
Plug 'romainl/vim-qf'
Plug 'plainOldCode/vim-quickui'
Plug 'fszymanski/fzf-quickfix'
Plug 'tpope/vim-rhubarb'

Plug 'junegunn/vim-peekaboo'
Plug 'vim-test/vim-test'
  let test#strategy = "neovim"
Plug 'arzg/vim-colors-xcode'
Plug 'tpope/vim-obsession'
Plug 'jpalardy/vim-slime'
  let g:slime_target = "neovim"

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let $BAT_THEME = 'ansi-dark'
  let $FZF_DEFAULT_OPTS = '--color=light --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --margin=1,4'
  let g:fzf_preview_window = 'up:50%:noborder'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')
    let height = float2nr(&lines * 0.65)
    let width = float2nr(&columns)
    let horizontal = float2nr((&columns - width) / 2)
    let vertical = &lines - height - 2

    let opts = {
          \ 'relative': 'editor',
          \ 'row': vertical,
          \ 'col': horizontal,
          \ 'width': width,
          \ 'height': height,
          \ 'style': 'minimal'
          \ }
    call nvim_open_win(buf, v:true, opts)
  endfunction

Plug 'antoinemadec/coc-fzf'
Plug 'psliwka/vim-smoothie'

" Notes
Plug 'vimwiki/vimwiki'
Plug 'dkarter/bullets.vim'

" Tags
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-projectionist'
Plug 'neovim/node-host'
Plug 'tpope/vim-dispatch'
Plug 'tomtom/tlib_vim'
Plug 'jonatan-branting/vim-dispatch-neovim'
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
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_guicolor = '#445566'

" Navigation and editing
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


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
Plug 'chaoren/vim-wordmotion'
Plug 'michaeljsmith/vim-indent-object'
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
Plug 'cideM/yui'
Plug 'ayu-theme/ayu-vim' "

call plug#end()

" ---- Auto Commands (Pertaining to filetypes or plugins) ----
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" ---- Remaps ----

" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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
nnoremap gw :exe ':Rg '.expand('<cword>')<CR>
vnoremap gw :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
xmap <leader>af <Plug>(coc-format-selected)
nmap <leader>af <Plug>(coc-format-selected)

nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Show chunkinfo easily
nmap gh <Plug>(coc-git-chunkinfo)

nmap <Leader>c :CocFzfListResume<CR>

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Organize imports
command! -nargs=0 Fimport :call CocAction('runCommand', 'editor.action.organizeImport')

" Lists

" Which-key
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.q = [':q', 'quit']

" File jumping
 noremap <silent> <Leader>p :Files<CR>
 noremap <silent> <C-p> :Files<CR>

nnoremap <silent> <C-f> :Rg<CR>
noremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>e :Buffers<CR>
nnoremap <silent> <Leader>i :exe ':Files '. expand("%:p:h")<CR>
let g:which_key_map.i =  'files-from-cwd'
let g:which_key_map.p =  'files-from-workspace'
let g:which_key_map.f = 'grep'

nnoremap <Leader>rc :Econtroller<CR>
nnoremap <Leader>rm :Emodel<CR>
nnoremap <Leader>rs :Espec<CR>
nnoremap <Leader>rv :Eview
nnoremap <Leader>rl :Elayout<CR>
nnoremap <Leader>rj :Ejavascript<CR>
let g:which_key_map.r = {
      \'name': 'ruby',
      \'r': [':R', 'open-related'],
      \'a': [':A', 'open-alternate'],
      \'f': ['gf', 'goto-file-under-cursor'],
      \'t': [':.Runner', 'run-closest-test'],
      \'T': [':Runner', 'run-file-test'],
      \'c': 'goto-controller',
      \'m': 'goto-model',
      \'s': 'goto-spec',
      \'v': 'goto-view-<insert>',
      \'l': 'goto-layout',
      \'j': 'goto-js',
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

let g:which_key_map.l = {
      \'name' : '+Lists',
      \'e'  : [':CocFzfList extensions', 'extensions'],
      \'s'  : [':CocFzfList sessions', 'sessions'],
      \'d'  : [':CocFzfList diagnostics', 'diagnostics'],
      \'l'  : [':Lines', 'lines'],
      \}

let g:which_key_map.a = {
      \'name' : '+Actions',
      \'x'  : ['<Plug>(coc-fix-current)',         'coc-fix-current'],
      \'l'  : ['<Plug>(coc-codeaction)',          'coc-codeaction-line'],
      \'s'  : ['<Plug>(coc-codeaction-selected)', 'coc-codeaction-selected'],
      \'r'  : ['<Plug>(coc-rename)',              'rename-at-cursor'],
      \'f'  : ['<Plug>(coc-format)',              'coc-format'],
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
nmap <Leader>hb :CocCommand git.showCommit<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
let g:which_key_map.h = { 'name' : '+hunks',}
let g:which_key_map.h.u = 'undo-chunk'
let g:which_key_map.h.s = 'stage-chunk'
let g:which_key_map.h.b = 'show-blame-info'
let g:which_key_map.h.n = 'next-chunk'
let g:which_key_map.h.p = 'prev-chunk'

nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>tr :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>
let g:which_key_map.t = { 'name' : '+test',}
let g:which_key_map.t.f = 'test-current-file'
let g:which_key_map.t.n = 'test-nearest'
let g:which_key_map.t.r = 'rerun-last-test'
let g:which_key_map.t.v = 'visit-test-file'

" create text object for git chunks
omap ic <Plug>(coc-git-chunk-inner)
xmap ic <Plug>(coc-git-chunk-inner)
omap ac <Plug>(coc-git-chunk-outer)
xmap ac <Plug>(coc-git-chunk-outer)

" Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Register which-key
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual ','<CR>

" ---- HELPER FUNCTIONS USED ABOVE ----

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
  execute 'Rg '.word
endfunction

" Search and repace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Import other files
runtime core-settings.vim
runtime colorscheme.vim
runtime statusline.vim
