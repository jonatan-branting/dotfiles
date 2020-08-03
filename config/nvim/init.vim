" Necessary settings for plugins. (Before they load)
let mapleader="\<Space>"
let maplocalleader=','


" ---- Enable plugins. ---- "

call plug#begin('~/.nvim/plugged')

" TODO move settings to their own files?

" General purpose and libraries
Plug 'svermeulen/vim-macrobatics'
Plug 'romainl/vim-qf'
Plug 'metakirby5/codi.vim'
Plug 'vim-vdebug/vdebug'
Plug 'plainOldCode/vim-quickui'
Plug 'bkad/CamelCaseMotion'
Plug 'fszymanski/fzf-quickfix'
Plug 'tpope/vim-rhubarb'
Plug 'jesseleite/vim-agriculture'

Plug 'junegunn/vim-peekaboo'
Plug 'vim-test/vim-test'
  let test#strategy = "neovim"
Plug 'arzg/vim-colors-xcode'
Plug 'tpope/vim-obsession'
Plug 'jpalardy/vim-slime'
  let g:slime_target = "neovim"

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
  let $BAT_THEME = 'base16'
  let $BAT_STYLE = 'changes'
  let $FZF_DEFAULT_OPTS = '--color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --margin=1,1'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }
  let g:fzf_preview_window = ''

  function! FloatingFZF()
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, '&signcolumn', 'no')
    let height = min([max([float2nr(winheight(0) * 0.35), 20]), &lines])
    let width = float2nr(winwidth(0))
    let horizontal = float2nr((winwidth(0) - width) / 2)
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
  let g:which_key_floating_relative_win = 1
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

" Import other setting-files
runtime mappings.vim
runtime core-settings.vim
runtime colorscheme.vim
runtime statusline.vim
