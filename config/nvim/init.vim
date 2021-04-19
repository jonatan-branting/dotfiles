" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" Libraries
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tjdevries/astronauta.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'

" General purpose
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-dispatch'
Plug 'jonatan-branting/vim-dispatch-neovim'

" Snippet
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<C-q>"

" LSP
Plug 'nvim-lua/lsp-status.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
" Git
Plug 'TimUntersberger/neogit'
Plug 'tpope/vim-rhubarb'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'ThePrimeagen/git-worktree.nvim'

" Sessions
Plug 'tpope/vim-obsession'
Plug 'mhinz/vim-startify'
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 0

" Navigation
Plug 'nvim-lua/telescope.nvim'
Plug 'tami5/sql.nvim'
Plug 'nvim-telescope/telescope-frecency.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'kevinhwang91/nvim-bqf'
Plug 'romainl/vim-qf'
Plug 'airblade/vim-rooter'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'tpope/vim-projectionist'

" Text editing
Plug 'AndrewRadev/splitjoin.vim'
Plug 'rhysd/clever-f.vim'
Plug 'terryma/vim-expand-region'
Plug 'machakann/vim-swap'
Plug 'haya14busa/vim-asterisk'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_guicolor = '#445566'
Plug 'antoinemadec/FixCursorHold.nvim'
  let g:cursorhold_updatetime = 100
Plug 'Raimondi/delimitMate'
  let g:delimitMate_expand_space = 1
  let g:delimitMate_expand_cr = 2

" Statusline
Plug 'famiu/feline.nvim'

" Notes
Plug 'dkarter/bullets.vim'

" Test
Plug 'vim-test/vim-test'
let g:test#strategy = "neovim"

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'vim-ruby/vim-ruby'
  let g:ruby_indent_hanging_elements = 0

" Lua
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'rafcamlet/nvim-luapad'
Plug 'euclidianAce/BetterLua.vim'

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

" Linting
Plug 'nathunsmitty/nvim-ale-diagnostic'
Plug 'dense-analysis/ale'
  let g:ale_sign_error = '_'
  let g:ale_set_highlights = 1
  let g:ale_change_sign_column_color = 1
  let g:ale_sign_column_always = 1
  let g:ale_virtualtext_cursor = 1
  let g:ale_echo_cursor = 1
  let g:ale_hover_cursor = 1
  let g:ale_floating_preview = 1
  let g:ale_hover_to_preview = 1
  let g:ale_sign_warning = '_'
  let g:ale_disable_lsp = 1
  let g:ale_fixers = { 'ruby': ['rubocop'], 'js': ['eslint', 'prettier'], 'vue': ['eslint', 'prettier']  }
  let g:ale_linters = {
        \ 'python': ['pylint'],
        \ 'ruby': ['rubocop'],
        \ 'js': ['eslint', 'prettier'],
        \ 'vue': ['eslint', 'prettier']
        \ }


" Sweet stuff
Plug 'dbeniamine/cheat.sh-vim'
Plug 'sotte/presenting.vim'

" Themes
Plug 'morhetz/gruvbox'

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
  au FileType qf setlocal nonumber norelativenumber wrap
augroup end

" Remap <esc> to leave terminal in insert mode
augroup terminal
  autocmd!
  au TermOpen * tnoremap <buffer> <esc> <c-\><c-n>
  au TermOpen * set nonu
  au TermOpen * vert | setlocal nonumber norelativenumber | exec "normal! G"
augroup end

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


" ---- Commands ----

" LspLog: take a quick peek at the latest LSP log messages. Useful for debugging
command! LspLog execute '<mods> pedit +$' v:lua.vim.lsp.get_log_path()

" LspStop: stop all active clients
command! LspStop lua vim.lsp.stop_client(vim.lsp.get_active_clients())

" Redirect: show the results of an ex command in a buffer rather than the built-in pager
command! -nargs=* -complete=command Redirect <mods> new | setl nonu nolist noswf bh=wipe bt=nofile | call append(0, split(execute(<q-args>), "\n"))

" Import other .viml setting-files
runtime core-settings.vim
runtime colorscheme.vim

" And finally, load lua configuration
lua require('init')
