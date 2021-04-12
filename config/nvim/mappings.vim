" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Emmet, make ,j not remove ,
imap ,, <C-y>,

inoremap <silent> kk <C-R>=UltiSnips#ExpandSnippetOrJump()<CR>

inoremap jj <Esc>
cnoremap jj <Esc>
tnoremap jj <Esc>
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

nnoremap p p`[v`]=`.
vnoremap d d==

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
nnoremap gw :exe ':Telescope grep_string search='.expand('<cword>')<CR>
vnoremap gw :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

nnoremap <C-e> $
nnoremap <C-a> 0

" Show chunkinfo easily
nmap gh <Plug>(coc-git-chunkinfo)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Organize imports
command! -nargs=0 Fimport :call CocAction('runCommand', 'editor.action.organizeImport')

" Which-key
" Replace which-key with quickui!
let g:which_key_map = {}
let g:which_key_map.s = [':w', 'save']
let g:which_key_map.j = ['<Esc>', 'exit-which-key']
let g:which_key_map.x = [':x', 'save-exit']
let g:which_key_map.q = [':q', 'quit']
let g:which_key_map.o = [':Fern . -drawer -toggle -width=32 -reveal=%', 'explore-project']

" File jumping
noremap <silent> <Leader>p :Telescope find_files<CR>
nnoremap <silent><Leader>f :Telescope live_grep_raw<CR>
nnoremap <silent> <Leader>e :Telescope buffers sort_lastused=true<CR>
nnoremap <silent> <Leader>i :Telescope find_files cwd=<C-R>=expand('%:h')<CR><CR>
let g:which_key_map.i = 'files-from-cwd'
let g:which_key_map.e = 'buffers'
let g:which_key_map.p = 'files-from-workspace'
let g:which_key_map.f = 'grep-from-workspace'
let g:which_key_map.v = 'grep-from-buffers'

"Open lines but stay in insert
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" Break undo sequence on specific characters
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" Open line below, with an extra blank line below that one
nnoremap <Leader><CR> o<C-o>O
let g:which_key_map['<CR>'] = 'open-line-below'

nnoremap <Leader>rc :Econtroller<CR>
nnoremap <Leader>rm :Emodel<CR>
nnoremap <Leader>rs :Espec<CR>
nnoremap <Leader>rv :Eview
nnoremap <Leader>rl :Elayout<CR>
nnoremap <Leader>rj :Ejavascript<CR>
let g:which_key_map.R = 'reload-chrome'
let g:which_key_map.r = {
      \'name': '+Ruby',
      \'r': [':Rails', 'run-file'],
      \'c': [':.Rails', 'run-current'],
      \'a': [':A', 'open-alternate'],
      \'f': ['gf', 'goto-file-under-cursor'],
      \'t': [':.Runner', 'run-closest-test'],
      \'T': [':Runner', 'run-file-test'],
      \'g': { 'name': 'goto' },
      \'gc': 'goto-controller',
      \'gr': 'goto-related',
      \'gm': 'goto-model',
      \'gs': 'goto-spec',
      \'gv': 'goto-view-<insert>',
      \'gl': 'goto-layout',
      \'gj': 'goto-js',
      \}

let g:which_key_map.w = {
      \'name' : '+Windows',
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
      \'b'  : [':BLines', 'buffer-lines'],
      \}

let g:which_key_map.a = {
      \'name' : '+Actions',
      \'x'  : ['<Plug>(coc-fix-current)',         'coc-fix-current'],
      \'l'  : ['<Plug>(coc-codeaction)',          'coc-codeaction-line'],
      \'s'  : ['<Plug>(coc-codeaction-selected)', 'coc-codeaction-selected'],
      \'r'  : ['<Plug>(coc-rename)',              'rename-at-cursor'],
      \'f'  : [':Format',                         'format'],
      \}

let g:which_key_map.b = {
      \'name' : '+Buffer',
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
nmap <Leader>gl :Git log<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gm :Git mergetool<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gf :GFiles<CR>
nmap <Leader>gg :Neogit<CR>
let g:which_key_map.g = { 'name' : '+Git',}
let g:which_key_map.g.s = 'git-status'
let g:which_key_map.g.c = 'git-commit'
let g:which_key_map.g.m = 'git-merge'
let g:which_key_map.g.p = 'git-push'
let g:which_key_map.g.l = 'git-log'
let g:which_key_map.g.f = 'git-list-files'
let g:which_key_map.g.g = 'neogit'

nmap <Leader>hs :CocCommand git.chunkStage<CR>
nmap <Leader>hu :CocCommand git.chunkUndo<CR>
nmap <Leader>hb :CocCommand git.showCommit<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
let g:which_key_map.h = { 'name' : '+Hunks',}
let g:which_key_map.h.u = 'undo-chunk'
let g:which_key_map.h.s = 'stage-chunk'
let g:which_key_map.h.b = 'show-blame-info'
let g:which_key_map.h.n = 'next-chunk'
let g:which_key_map.h.p = 'prev-chunk'

nmap <Leader>tn :TestNearest<CR>
nmap <Leader>tf :TestFile<CR>
nmap <Leader>tr :TestLast<CR>
nmap <Leader>tv :TestVisit<CR>
let g:which_key_map.t = { 'name' : '+Test',}
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
nmap <silent> <Leader>R :w<CR>:call system('chrome-cli reload')<CR>

" Use CTRL-S for selections ranges.
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
  execute 'Telescope grep_string search='.word
endfunction

" Search and repace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>


" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
