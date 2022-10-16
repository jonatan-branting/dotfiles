local opt = vim.opt

vim.g.mapleader = " "

opt.termguicolors = true

opt.number = true
opt.relativenumber = true

opt.list = true

opt.linebreak = true
opt.breakindent = true
opt.showmode = false
opt.pumblend = 12
opt.splitkeep = "topline"
opt.winblend = 8
opt.updatetime = 2000
opt.shortmess = "filnxtToOFcI"
opt.hidden = true
opt.mouse = "a"

opt.inccommand = "nosplit"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smarttab = true

opt.scrolloff = 2
opt.lazyredraw = false

opt.wildignore = "*.swp,*.bak,*.pyc, *.class"
opt.wildmenu = true
opt.wildmode = "full"
opt.showmode = false

opt.cursorline = false
opt.relativenumber = true
opt.number = true

opt.history = 10000
opt.undolevels = 10000

opt.undodir = os.getenv("HOME") .. '/.cache/nvim/undo'
opt.undofile = true
opt.swapfile = false
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.equalalways = true

opt.foldlevel = 99
opt.foldenable = true

opt.visualbell = true
opt.errorbells = false

opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true

-- opt.shell = "zsh"

opt.timeoutlen = 500
opt.linebreak = true
opt.autoindent = true
opt.breakindent = true
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true

opt.laststatus = 3

opt.signcolumn = "auto"

opt.exrc = true
opt.secure = true
opt.termguicolors = true
opt.wrap = false
opt.clipboard = "unnamedplus"

vim.g.vimsyn_embed = "l" -- Highlight Lua code inside .vim files
