" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" Libraries
Plug 'kosayoda/nvim-lightbulb'
Plug 'nvim-lua/plenary.nvim'
Plug 'jedrzejboczar/possession.nvim'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'kana/vim-textobj-user'
Plug 'folke/trouble.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'mrjones2014/smart-splits.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'yioneko/nvim-yati'
Plug 'kwkarlwang/bufresize.nvim'
Plug 'vim-scripts/text-object-left-and-right'
Plug 'MunifTanjim/nui.nvim'
Plug 'sunjon/stylish.nvim'
Plug 'gbprod/substitute.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'andymass/vim-matchup'
Plug 'famiu/bufdelete.nvim'
Plug 'max397574/better-escape.nvim'
Plug 'rhysd/conflict-marker.vim'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'David-Kunz/treesitter-unit'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'tomtom/tlib_vim'
Plug 'nvim-neorg/neorg'
Plug 'rbong/vim-buffest'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
Plug 'mjlbach/neovim-ui'
Plug 'jonatan-branting/vim-dispatch-neovim'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-telescope/telescope-dap.nvim'

" General purpose
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'pbogut/fzf-mru.vim'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'junegunn/fzf.vim'

let $BAT_THEME = 'Nord'
let $SHELL = '/bin/sh'
let $BAT_STYLE = 'changes'
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude tags'
let $FZF_DEFAULT_OPTS = '--algo=v2 --margin=0,0,0,0 --info=inline --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up --keep-right --color=hl:reverse,hl+:reverse --bind ctrl-v:toggle-all'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_preview_window = 'up:50%:sharp'
let g:fzf_history_dir = '~/.local/share/fzf-history'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split'}

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" let g:fzf_lsp_layout = { 'window': 'call FloatingLSPFZF()' }
let g:fzf_preview_window = 'up:50%:sharp'

function! FloatingLSPFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = min([max([float2nr(winheight(0) * 0.4), 25]), &lines])
  let width = float2nr(winwidth(0) * 3/4)
  let horizontal = 0
  let vertical = -height
  let opts = {
        \ 'relative': 'cursor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'border': 'rounded',
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  call nvim_open_win(buf, v:true, opts)
endfunction

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = min([max([float2nr(&lines * 0.7), 25]), &lines])
  let width = winwidth(0)
  let horizontal = getwininfo(win_getid())[0]['wincol']
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

" UI
Plug 'rmagatti/goto-preview'
Plug 'roman/golden-ratio'
  let g:golden_ratio_autocommand = 0
Plug 'folke/which-key.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
  let g:indent_blankline_filetype_exclude = ['help', 'fern', 'startify']
  let g:indent_blankline_show_current_context = 1
  let g:indent_blankline_char = '▏'
  let g:indent_blankline_use_treesitter = v:true
  let g:indent_blankline_context_patterns = ['^if', 'class', 'function', 'method', 'do', 'then', 'for', 'while']
  let g:indent_blankline_enabled = v:false " Too laggy

" Snippet
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
  let g:UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
  let g:UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
  let g:UltiSnipsListSnippets = '<c-x><c-s>'
  let g:UltiSnipsRemoveSelectModeMappings = 0

" LSP
Plug 'nvim-lua/lsp-status.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-dd'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
Plug 'wincent/terminus'
"
" Git
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'ThePrimeagen/git-worktree.nvim'

" Sessions
Plug 'mhinz/vim-startify'
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 0

" Navigation
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'kevinhwang91/nvim-bqf'
Plug 'romainl/vim-qf'
Plug 'airblade/vim-rooter'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'

" Text editing
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'machakann/vim-swap'
Plug 'haya14busa/vim-asterisk'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
Plug 'windwp/nvim-autopairs'
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_guicolor = '#445566'
Plug 'antoinemadec/FixCursorHold.nvim'
  let g:cursorhold_updatetime = 500
Plug 'windwp/nvim-ts-autotag'

" Statusline
Plug 'famiu/feline.nvim'

" Notes
Plug 'dkarter/bullets.vim'

" Terminals
Plug 'kassio/neoterm'
  let g:neoterm_autoscroll = 1
  let g:neoterm_autojump = 1
  let g:neoterm_term_per_tab = 1
  let g:neoterm_shell = "/usr/local/bin/fish"

  vnoremap <Leader>2 :TREPLSendSelection<cr>
  nnoremap <Leader>3 :TREPLSendLine<cr>
  nnoremap <Leader>4 :TREPLSendFile<cr>
  nnoremap <Leader>tm :Tmap<cr>
  nnoremap <Leader>- :Tnew<cr>
  nnoremap <Leader>c :Tfocus<cr>

  let g:neoterm_callbacks = {}

  " Test
Plug 'vim-test/vim-test'
  let test#strategy = "neoterm"
  " let test#harpoon_term = 2
  let test#ruby#rspec#options = {
    \ 'file':    '--format documentation',
  \}

  " Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" LaTeX
" Plug 'lervag/vimtex'

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-bundler'
Plug 'nvim-treesitter/playground'
Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_hanging_elements = 0

" Lua
"
Plug 'tjdevries/nlua.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'euclidianAce/BetterLua.vim'
Plug 'bfredl/nvim-luadev'

" Web
Plug 'mattn/emmet-vim'
Plug 'kchmck/vim-coffee-script'
Plug 'leafOfTree/vim-vue-plugin'
  let g:vim_vue_plugin_config = {
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'attribute': 0,
      \'keyword': 1,
      \'foldexpr': 0,
      \'debug': 0,
      \'init_indent': 0,
      \}
Plug 'mfussenegger/nvim-lint'
" Sweet stuff
Plug 'sotte/presenting.vim'

" Themes
Plug 'rktjmp/lush.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'Mofiqul/dracula.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'bluz71/vim-moonfly-colors'

call plug#end()

" ---- Global variables ----
let g:python3_host_prog = '$HOME/.pyenv/versions/neovim3/bin/python'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby']

" ---- Auto Commands ----

au InsertLeave * set nopaste
au FileType json syntax match Comment +\/\/.\+$+

" Ensure .tikz files get the correct syntax highlighting
augroup tex
  autocmd FileType tikz set syntax=tex
augroup end

" Fix quickfix styling
augroup quickfix
  autocmd!
  au FileType qf nnoremap <buffer> d :.Reject<cr>
  au FileType qf nnoremap <buffer> D :Reject<space>
augroup end

augroup fzf
  autocmd!
  " au FileType fzf set shell="/bin/sh"
  " au FileType fzf inoremap <buffer><silent> <esc> <c-o>:close<cr>
  " au FileType "" nnoremap <buffer><silent> <esc> <c-o>:close<cr>
  au FileType git nnoremap <buffer><silent> <esc> :close<cr>
  au FileType fugitive nnoremap <buffer><silent> <esc> :close<cr>
  au FileType fzf autocmd WinLeave * ++once close
augroup END

augroup fern
  autocmd!
  au FileType fern setlocal nonumber norelativenumber
augroup end

" augroup telescope
"   autocmd!
  " au FileType telescope let b:lexima_disabled = 1
  " au FileType TelescopePrompt :DelimitMateOff
" augroup END

" Remap <esc> to leave terminal in insert mode

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
augroup terminal
  autocmd!

  " au TermOpen * nnoremap <cr> gF
  " au TermOpen * tnoremap <buffer> <esc> <c-\><c-n>
  " au TermOpen * set nonu
  " au TermOpen * vert | setlocal nonumber norelativenumber | exec "normal! i<esc>"
augroup end

" neogit
" augroup neogit
"   autocmd!
"   " au TermOpen * tnoremap <buffer> <esc> <c-\><c-n>
"   " au BufWinEnter NeogitStatus 
"   au TermOpen * set nonu
"   au TermOpen * vert | setlocal nonumber norelativenumber | exec "normal! G"
" augroup end

" hl_yank: highlight the area that was just yanked
augroup hl_yank
  autocmd!
  autocmd TextYankPost * lua require('vim.highlight').on_yank()
augroup end

" restore_curpos: restore the last position of the cursor in a file. Taken from Vim's defaults.vim
" augroup restore_curpos
"   autocmd!
"   autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
" augroup end

" vimwiki: automatically generate diary links
augroup vimwiki
    autocmd!
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end


augroup rails
  autocmd!
  autocmd User Rails compiler rspec
  autocmd User Rails let b:dispatch = 'rspec %'
augroup end

" ---- Commands ----

" LspLog: take a quick peek at the latest LSP log messages. Useful for debugging
command! LspLog execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()

" LspStop: stop all active clients
command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())

" Redirect: show the results of an ex command in a buffer rather than the built-in pager
command! -nargs=* -complete=command Redirect <mods> new | setl nonu nolist noswf bh=wipe bt=nofile | call append(0, split(execute(<q-args>), "\n"))

function! DeleteSurroundingMatch()
  execute "echo " . string("ds") . string(matchstr(getline('.'), '\%' . col('.') . 'c.'))
endfunction

" ---- Callbacks ----
function! OnChangeVueSubtype(subtype)
  if a:subtype == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:subtype =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction

let &t_Cs = "\e[6m"
let &t_Ce = "\e[24m"

" And finally, load lua configuration
lua require('init')

nnoremap <silent> <leader>l :noh<CR>
cnoreabbrev <expr> bd ((getcmdtype() is# ':' && getcmdline() is# 'bd')?('Bdelete'):('bd'))
cnoreabbrev <expr> bdelete ((getcmdtype() is# ':' && getcmdline() is# 'bd')?('Bdelete'):('bd'))

" Otherwise unicode characters cannot be pasted properle
lang en_US.utf-8

function! ToggleZoom(toggle)
  let current_win_config = nvim_win_get_config(win_getid())

  " is floating
  if current_win_config['relative'] != ''
    return
  endif

  if exists("t:restore_zoom") && (t:restore_zoom.win != winnr() || a:toggle == v:true)
      exec t:restore_zoom.cmd
      unlet t:restore_zoom
  elseif a:toggle
      let t:restore_zoom = { 'win': winnr(), 'cmd': winrestcmd() }
      vert resize | resize
  endi
endfunction

nnoremap <silent> <Leader><leader> :call ToggleZoom(v:true)<CR>

augroup restorezoom
    au WinEnter * silent! :call ToggleZoom(v:false)
augroup END

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

vnoremap <silent><nowait> < <gv
nnoremap <Leader>c :Tfocus<cr>



nnoremap g. /\V<C-r>"<CR>cgn<C-a><Esc>

set rtp+=/usr/local/opt/fzf


highlight FZFNormal guibg=#0d0d0d

let g:fzf_colors =
      \ { 'fg':       ['fg', 'Normal'],
      \ 'bg':         ['bg', 'FZFNormal'],
      \ 'hl':         ['fg', 'Normal',],
      \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
      \ 'preview-bg': ['bg', 'Comment'],
      \ 'preview-fg': ['bg', 'CursorLine'],
      \ 'hl+':        ['fg', 'Normal'],
      \ 'info':       ['fg', 'PreProc'],
      \ 'border':     ['fg', 'CursorLine'],
      \ 'prompt':     ['fg', 'Conditional'],
      \ 'pointer':    ['fg', 'Exception'],
      \ 'marker':     ['fg', 'Keyword'],
      \ 'spinner':    ['fg', 'Label'],
      \ 'header':     ['fg', 'Comment'] }

autocmd FileType gitlog,gitcommit,gitrebase,gitconfig set bufhidden=delete

nnoremap <cr> <Plug>(unimpaired-blank-down)
nnoremap <s-cr> <Plug>(unimpaired-blank-up)
