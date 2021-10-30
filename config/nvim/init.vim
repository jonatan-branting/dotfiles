" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" Libraries
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tjdevries/astronauta.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'famiu/bufdelete.nvim'
Plug 'David-Kunz/treesitter-unit'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" Plug 'fhill2/telescope-ultisnips.nvim'
" Plug 'vijaymarupudi/nvim-fzf-commands'
" Plug 'vijaymarupudi/nvim-fzf'
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
" Plug 'nikvdp/neomux'
"   let g:neomux_win_num_status = ''
"   let g:neomux_default_shell = '/usr/local/bin/fish'
"   let g:neomux_dont_fix_term_ctrlw_map = 1
"   let g:neomux_no_exit_term_map = 1
"   let g:neomux_start_term_split_map = "<leader>ws"
"   let g:neomux_start_term_vsplit_map = "<leader>wv"
Plug 'mjlbach/neovim-ui'
Plug 'jonatan-branting/vim-dispatch-neovim'
" Plug 'lambdalisue/pastefix.vim'
" Plug 'kevinhwang91/nvim-hlslens'
" Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-telescope/telescope-dap.nvim'
" Plug 'vim-scripts/repeatable-motions.vim' -- doesnt work anymore
" General purpose
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'pbogut/fzf-mru.vim'
" Plug 'alvarosevilla95/luatab.nvim'
" Plug 'akinsho/nvim-toggleterm.lua'
" Plug 'rcarriga/vim-ultest'
"   let g:ultest_use_pty = 1
"   let g:ultest_max_threads = 1
" Plug 'puremourning/vimspector'
"   let g:vimspector_enable_mappings = 'HUMAN'
" Plug 'camspiers/snap'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'junegunn/fzf.vim'

let $BAT_THEME = 'Nord'
let $SHELL = '/bin/zsh'
let $BAT_STYLE = 'changes'
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude tags'
let $FZF_DEFAULT_OPTS = '--algo=v2 --margin=0,0,0,0 --info=inline --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up --keep-right --color=hl:reverse,hl+:reverse'
" let $FZF_DEFAULT_OPTS_ = '--algo=v2 --margin=0,0,0,0 --info=inline --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up --keep-right --color=hl:reverse,hl+:reverse'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_preview_window = 'up:50%:sharp'
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_colors =
      \ { 'fg':       ['fg', 'Normal'],
      \ 'bg':         ['bg', '#1f2335'],
      \ 'hl':         ['fg', 'DiffText',],
      \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
      \ 'preview-bg': ['bg', 'Normal'],
      \ 'preview-fg': ['bg', 'CursorLine'],
      \ 'hl+':        ['fg', 'Normal'],
      \ 'info':       ['fg', 'PreProc'],
      \ 'border':     ['fg', 'CursorLine'],
      \ 'prompt':     ['fg', 'Conditional'],
      \ 'pointer':    ['fg', 'Exception'],
      \ 'marker':     ['fg', 'Keyword'],
      \ 'spinner':    ['fg', 'Label'],
      \ 'header':     ['fg', 'Comment'] }

  let g:fzf_action = {
        \ 'ctrl-q': 'wall | bdelete',
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': 'call FloatingFZF()' }
" let g:fzf_lsp_layout = { 'window': 'call FloatingLSPFZF()' }
let g:fzf_preview_window = 'up:50%:sharp'

function! FloatingLSPFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = min([max([float2nr(winheight(0) * 0.4), 25]), &lines])
  let width = float2nr(winwidth(0) * 3/4)
  let horizontal = 0 "getwininfo(win_getid())[0]['wincol']
  let vertical = -height "&lines - height - 2
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
  let height = min([max([float2nr(winheight(0) * 0.5), 25]), &lines])
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
" Plug 'Iron-E/nvim-libmodal'
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
  let g:UltiSnipsExpandTrigger="<nop>"

" LSP
Plug 'nvim-lua/lsp-status.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/cmp-path'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'https://gitlab.com/yorickpeterse/nvim-dd'
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf.git'
Plug 'wincent/terminus'
Plug 'folke/lsp-trouble.nvim'
" Plug 'ray-x/lsp_signature.nvim'
" TODO Maybe use these?
" Plug 'weilbith/nvim-lsp-smag'
" Plug 'weilbith/nvim-floating-tag-preview'
"
" Git
Plug 'TimUntersberger/neogit'
Plug 'sindrets/diffview.nvim'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
" Plug 'lambdalisue/gina.vim'
Plug 'ThePrimeagen/git-worktree.nvim'

" Sessions
Plug 'tpope/vim-obsession'
Plug 'Shatur/neovim-session-manager'
Plug 'mhinz/vim-startify'
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 0

" Navigation
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
" Plug 'ThePrimeagen/harpoon'
Plug 'kevinhwang91/nvim-bqf'
Plug 'romainl/vim-qf'
Plug 'airblade/vim-rooter'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'tpope/vim-projectionist'
" Plug 'ggandor/lightspeed.nvim'
" Plug 'vijaymarupudi/nvim-fzf-commands'
" Plug 'vijaymarupudi/nvim-fzf'

" Text editing
Plug 'sheerun/vim-polyglot'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'AndrewRadev/splitjoin.vim'
" Plug 'terryma/vim-expand-region'
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
Plug 'tpope/vim-endwise'
"   let g:endwise_no_mappings = 1
" Plug 'windwp/nvim-autopairs'
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_guicolor = '#445566'
Plug 'antoinemadec/FixCursorHold.nvim'
  let g:cursorhold_updatetime = 100
Plug 'Raimondi/delimitMate'
  let g:delimitMate_expand_space = 1
  let g:delimitMate_excluded_ft = 'TelescopePrompt'
Plug 'windwp/nvim-ts-autotag'
" Plug 'matze/vim-move'
"   let g:move_key_modifier = 'C'

" Statusline
Plug 'famiu/feline.nvim'

" Notes
Plug 'dkarter/bullets.vim'

" Terminals
Plug 'kassio/neoterm'
  let g:neoterm_size = "11"
  let g:neoterm_autoscroll = 1
  let g:neoterm_autojump = 1
  let g:neoterm_term_per_tab = 1
  let g:neoterm_shell = "/usr/local/bin/fish"
  vnoremap <Leader>2 :TREPLSendSelection<cr>
  nnoremap <Leader>2 :TREPLSendLine<cr>
  nnoremap <Leader>4 :TREPLSendFile<cr>
  nnoremap <Leader>3 :Tmap<cr>
  nnoremap <Leader>- :Ttoggle<cr>

  let g:neoterm_callbacks = {}
  function! g:neoterm_callbacks.before_new()
    if winwidth('.') > 200
      let g:neoterm_default_mod = 'botright vertical'
      let g:neoterm_size = ""
    else
      let g:neoterm_default_mod = 'botright'
      let g:neoterm_size = "11"
    end
  endfunction

  " Test
Plug 'vim-test/vim-test'
  let test#strategy = "neoterm"
  " let test#harpoon_term = 2
  let test#ruby#rspec#options = {
    \ 'file':    '--format documentation',
  \}

  " Debugging
Plug 'dosimple/workspace.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'
" Plug 'SmiteshP/nvim-gps'

" LaTeX
" Plug 'lervag/vimtex'

" Ruby
Plug 'tpope/vim-rails'
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
" Linting
" Plug 'nathunsmitty/nvim-ale-diagnostic'
" Plug 'dense-analysis/ale' " TODO replace with efm in the future
"   let g:ale_virtualtext_prefix = ' • '
"   let g:ale_set_highlights = 1
"   let g:ale_change_sign_column_color = 1
"   " let g:ale_sign_column_always = 1
"   let g:ale_virtualtext_cursor = 1
"   let g:ale_echo_cursor = 1
"   let g:ale_hover_cursor = 1
"   let g:ale_floating_preview = 1
"   let g:ale_hover_to_preview = 1
"   let g:ale_sign_warning = '•'
"   let g:ale_sign_info = '•'
"   let g:ale_sign_error = '•'
"   let g:ale_sign_highlight_linenrs = 1
"   let g:ale_disable_lsp = 1
"   let g:ale_fixers = {
"         \ 'ruby': ['rubocop'],
"         \ 'haml': ['rubocop'],
"         \ 'js': ['eslint'],
"         \ 'vue': ['eslint']
"         \ }

"   let g:ale_linters = {
"         \ 'python': ['pylint'],
"         \ 'ruby': ['rubocop'],
"         \ 'js': ['eslint'],
"         \ 'vue': ['eslint']
"         \ }


" Sweet stuff
" Plug 'dbeniamine/cheat.sh-vim'
  " let g:CheatSheetDoNotMap = 1
Plug 'sotte/presenting.vim'
" Plug 'famiu/nvim-reload'

" Themes
Plug 'rktjmp/lush.nvim'
Plug 'eddyekofo94/gruvbox-flat.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'lifepillar/vim-gruvbox8'
Plug 'Mofiqul/dracula.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'bluz71/vim-moonfly-colors'
" Plug 'norcalli/nvim-colorizer.lua'

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
  " au FileType fzf nnoremap <buffer><silent> <esc> <c-o>:close<cr>
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

  au TermOpen * nnoremap <cr> gF
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
augroup restore_curpos
  autocmd!
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
augroup end

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

" Import other .viml setting-files
runtime core-settings.vim

let &t_Cs = "\e[6m"
let &t_Ce = "\e[24m"

" And finally, load lua configuration
lua require('init')

" noremap <silent> n <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
"       \<Cmd>lua require('hlslens').start()<CR>
" noremap <silent> N <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
"       \<Cmd>lua require('hlslens').start()<CR>
" noremap * *<Cmd>lua require('hlslens').start()<CR>
" noremap # #<Cmd>lua require('hlslens').start()<CR>
" noremap g* g*<Cmd>lua require('hlslens').start()<CR>
" noremap g# g#<Cmd>lua require('hlslens').start()<CR>

nnoremap <silent> <leader>l :noh<CR>
" let $MANPAGER="nvr +Man! -"
cnoreabbrev <expr> bd ((getcmdtype() is# ':' && getcmdline() is# 'bd')?('Bdelete'):('bd'))
cnoreabbrev <expr> bdelete ((getcmdtype() is# ':' && getcmdline() is# 'bd')?('Bdelete'):('bd'))

" Otherwise unicode characters cannot be pasted properle
lang en_US.utf-8

" function! DebugStrategy(cmd)
"   " let filename = matchlist(a:cmd, '\v'' (.*)$')[1]
"   let filename = split(a:cmd)[1]
"   echom filename
"   call luaeval("debug_rspec(\'" . filename . "\')")
" endfunction

" let g:test#custom_strategies = {'debug': function('DebugStrategy')}
" let g:test#strategy = 'debug'
function! BetterStrategy(cmd)
  let filename = split(a:cmd)[1]
  let cmd = split(a:cmd)[0]
  call luaeval("better_test(\'" . cmd . "\', \'" . filename . "\')")
endfunction

let g:test#custom_strategies = {'better_test': function('BetterStrategy')}
" let g:test#strategy = 'better_test'
"
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
