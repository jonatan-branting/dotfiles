local opt = vim.opt

opt.termguicolors = true

opt.number = true
opt.relativenumber = true

opt.list = true

opt.linebreak = true
opt.breakindent = true
opt.showmode = false
opt.pumblend = 10
opt.updatetime = 300
opt.shortmess = "filnxtToOFcI"
opt.hidden = true
opt.mouse = "a"

opt.inccommand = "split"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smarttab = true

opt.scrolloff = 7
opt.lazyredraw = false

opt.wildignore = "*.swp,*.bak,*.pyc, *.class"
opt.wildmenu = true
opt.wildmode = "full"
opt.showmode = false

opt.cursorline = false
opt.relativenumber = true
opt.number = true
vim.api.nvim_exec([[set fillchars+=vert:\|]], false) -- How do I do this using lua?

opt.history = 10000
opt.undolevels = 10000
opt.undodir  = "~/.nvim/undo-dir"
opt.undofile = true
opt.swapfile = false
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.equalalways = true

opt.foldmethod = "manual"
opt.visualbell = true
opt.errorbells = false

opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true

opt.shell = "zsh"

opt.timeoutlen = 500
opt.linebreak = true
opt.autoindent = true
opt.breakindent = true
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true

opt.laststatus = 3

opt.exrc = true
opt.secure = true
opt.termguicolors = true
opt.wrap = false
opt.clipboard = "unnamedplus"

vim.g.vimsyn_embed = "l" -- Highlight Lua code inside .vim files
