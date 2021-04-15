" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"

" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" General purpose and libraries
Plug 'svermeulen/vimpeccable'
Plug 'kevinhwang91/nvim-bqf'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'nvim-lua/lsp-status.nvim'
Plug 'tjdevries/astronauta.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'famiu/feline.nvim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'sotte/presenting.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'TimUntersberger/neogit'
Plug 'mattn/emmet-vim'

Plug 'kchmck/vim-coffee-script'
Plug 'leafOfTree/vim-vue-plugin'
  let g:vim_vue_plugin_use_scss = 1
  let g:vim_vue_plugin_has_init_indent = 1
  let g:vim_vue_plugin_highlight_vue_keyword = 1

Plug 'romgrk/barbar.nvim'
  let g:bufferline = {}
  let g:bufferline.animation = v:false

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'theHamsta/nvim-dap-virtual-text'
  let g:dap_virtual_text = 1

Plug 'kyazdani42/nvim-web-devicons'
Plug 'morhetz/gruvbox'
Plug 'lifepillar/gruvbox8'
Plug 'dense-analysis/ale'
  let g:ale_sign_error = '_'
  let g:ale_set_highlights = 1
  let g:ale_change_sign_column_color = 1
  let g:ale_sign_column_always = 1
  let g:ale_virtualtext_cursor = 1
  let g:ale_echo_cursor = 1
  let g:ale_sign_warning = '_'
  let g:ale_disable_lsp = 1
  let g:ale_fixers = { 'ruby': ['standardrb', 'rubocop'], 'js': ['eslint', 'prettier'], 'vue': ['eslint', 'prettier']  }
  let g:ale_linters = {
        \ 'python': ['pylint'],
        \ 'ruby': ['standardrb','rubocop'],
        \ 'js': ['eslint', 'prettier'],
        \ 'vue': ['eslint', 'prettier']
        \ }

Plug 'pbogut/fzf-mru.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'romainl/vim-qf'
Plug 'antoinemadec/coc-fzf'
  let g:coc_fzf_preview = ''
  let g:coc_fzf_opts = []
Plug 'rhysd/clever-f.vim'
Plug 'Raimondi/delimitMate'
  let delimitMate_expand_space = 1
  let delimitMate_expand_cr = 2


Plug 'airblade/vim-rooter'
Plug 'terryma/vim-expand-region'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-rhubarb'
Plug 'jesseleite/vim-agriculture'

Plug 'vim-test/vim-test'
  let test#strategy = "neovim"

Plug 'tpope/vim-obsession'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let $BAT_THEME = 'zenburn'
  let $BAT_STYLE = 'changes'

  let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude tags'
  let $FZF_DEFAULT_OPTS = '--algo=v2 --margin=0,0,0,0 --info=inline --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up --keep-right --color=hl:reverse,hl+:reverse --border=rounded'

  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
  let g:fzf_preview_window = 'up:50%:sharp'
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_colors =
        \ { 'fg':       ['fg', 'Normal'],
        \ 'bg':         ['bg', 'SignColumn'],
        \ 'hl':         ['fg', 'DiffText',],
        \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
        \ 'preview-bg': ['bg', 'Normal'],
        \ 'preview-fg': ['bg', 'CursorLine'],
        \ 'hl+':        ['fg', 'Normal'],
        \ 'info':       ['fg', 'PreProc'],
        \ 'border':     ['fg', 'Comment'],
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

" Notes
Plug 'dkarter/bullets.vim'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-rails'
Plug 'antoinemadec/FixCursorHold.nvim'
  let g:cursorhold_updatetime = 100
Plug 'tpope/vim-projectionist'
Plug 'neovim/node-host'
Plug 'tpope/vim-dispatch'
Plug 'tomtom/tlib_vim'
Plug 'jonatan-branting/vim-dispatch-neovim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'xolox/vim-misc'
Plug 'mhinz/neovim-remote'
Plug 'dhruvasagar/vim-zoom'

" Session
Plug 'mhinz/vim-startify'
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 0

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'airblade/vim-gitgutter'
  let g:gitgutter_signs = 0

" Auto completion, snippets and linting
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  let g:coc_explorer_global_presets = {
        \   '.vim': {
        \     'root-uri': '~/.vim',
        \   },
        \   'tab': {
        \     'position': 'tab',
        \     'quit-on-open': v:true,
        \   },
        \   'floating': {
        \     'position': 'floating',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingTop': {
        \     'position': 'floating',
        \     'floating-position': 'center-top',
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingLeftside': {
        \     'position': 'floating',
        \     'floating-position': 'left-center',
        \     'floating-width': 50,
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'floatingRightside': {
        \     'position': 'floating',
        \     'floating-position': 'right-center',
        \     'floating-width': 50,
        \     'open-action-strategy': 'sourceWindow',
        \   },
        \   'simplify': {
        \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
        \   }
        \ }

Plug 'sbdchd/neoformat'
  let g:neoformat_enabled_python = ['black']
  let g:neoformat_enabled_ruby = ['rubocop']

Plug 'Shougo/neoinclude.vim'
Plug 'honza/vim-snippets'
Plug 'ntpeters/vim-better-whitespace'
  let g:better_whitespace_guicolor = '#445566'

" Navigation and editing
Plug 'haya14busa/vim-asterisk'
  map *   <Plug>(asterisk-*)
  map #   <Plug>(asterisk-#)
  map g*  <Plug>(asterisk-g*)
  map g#  <Plug>(asterisk-g#)
  map z*  <Plug>(asterisk-z*)
  map gz* <Plug>(asterisk-gz*)
  map z#  <Plug>(asterisk-z#)
  map gz# <Plug>(asterisk-gz#)

Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<C-q>"
  " let g:UltiSnipsJumpForwardTrigger="<tab>"
  " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Plug 'jonatan-branting/vim-which-key'
  let g:which_key_use_floating_win = 1
  let g:which_key_floating_relative_win = 0
  let g:which_key_align_by_separator = 0
  let g:which_key_flatten = 0
  let g:which_key_run_map_on_popup = 1
  let g:which_key_display_names = {'<CR>': '↵', '<C-I>': '⇆', '<TAB>': '⇆', ' ': '__', '<BS>': '⌫'}
  let g:which_key_timeout = 300

Plug 'matze/vim-tex-fold'
Plug 'tmhedberg/SimpylFold'
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
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'dracula/vim'
Plug 'voldikss/vim-floaterm'

call plug#end()

" let g:endwise_no_mappings = v:true

nmap <silent> gr <Plug>(coc-references)
lua require('init')

" lua << EOF
" local lspconfig = require'lspconfig'
" lspconfig.solargraph.setup{}
" vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
" EOF

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" let g:endwise_no_mappings = v:true
" inoremap <silent> <CR>

" ---- Auto Commands (Filetypes or plugins) ----
autocmd BufRead * normal zR
autocmd FileType tikz set syntax=tex

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Import other setting-files
runtime mappings.vim
runtime core-settings.vim
runtime colorscheme.vim

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby']
