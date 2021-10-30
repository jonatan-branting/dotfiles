require('modules._feline')
require('modules.dap')
require('modules.cmp')
require('modules._lsp')
require('modules.bqf')
require('modules.gitsigns')
require('modules.notifications')
require('modules.treesitter')
require('modules._telescope')
require('modules.neogit')
require('modules.diffview')
require("modules.refactoring")
require('mappings')
require('modules.autotag')
require('colorscheme')

-- require('modules.tabline').setup()
require("pqf").setup()
require("dd").setup()

-- require('colorizer').setup()
-- require('hlslens').setup()
require("git-worktree").setup({
  update_on_change = true,
  clearjumps_on_change = true
})

require('session_manager').setup({
  sessions_dir = vim.fn.stdpath('data') .. '/sessions', -- The directory where the session files will be saved.
  path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  autoload_last_session = false, -- Automatically load last session on startup is started without arguments.
  autosave_last_session = true, -- Automatically save last session on exit.
  autosave_ignore_paths = { '~' }, -- Folders to ignore when autosaving a session.
})

require("goto-preview").setup({})

-- tabline = require("luatab").tabline

-- local format_tab = require("luatab").formatTab

-- local tabline = function()
--     local i = 1
--     local line = ''
--     while i <= vim.fn.tabpagenr('$') do
--         line = line .. formatTab(i)
--         i = i + 1
--     end
--     return  line .. 'TabLineFill#%='
-- end

-- vim.cmd [[ set tabline=%!luaeval('tabline()') ]]

P = function(v)
  print(vim.inspect(v))
  return v
end

if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  ReloadPackage = function(name)
    RELOAD(name)
    return require(name)
  end

  ReloadFunc = function(pname, funcName)
    return function(...)
      local package = ReloadPackage(pname);
      return package[funcName](...);
    end
  end
end

-- TODO: Remove when https://github.com/neovim/neovim/pull/13479 lands
local opts_info = vim.api.nvim_get_all_options_info()
local opt = setmetatable({}, {
  __index = vim.o,
  __newindex = function(_, key, value)
    vim.o[key] = value
    local scope = opts_info[key].scope
    if scope == "win" then
      vim.wo[key] = value
    elseif scope == "buf" then
      vim.bo[key] = value
    end
  end,
})

opt.termguicolors = true

opt.number = true
opt.relativenumber = true
-- opt.signcolumn = 'number'

opt.list = true

opt.linebreak = true
opt.breakindent = true
opt.showmode = false
opt.pumblend = 10
opt.updatetime = 300
opt.shortmess = opt.shortmess .. 'cI'
opt.hidden = true
opt.mouse = 'a'

opt.inccommand = 'split'

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smarttab = true

opt.scrolloff = 7
opt.lazyredraw = false

opt.wildignore = '*.swp,*.bak,*.pyc, *.class'
opt.wildmenu = true
opt.wildmode = 'full'
opt.showmode = false

opt.cursorline = false
opt.relativenumber = true
opt.number = true
vim.api.nvim_exec([[set fillchars+=vert:\|]], false) -- How do I do this using lua?

opt.history = 10000
opt.undolevels = 10000
opt.undodir  = '~/.nvim/undo-dir'
opt.undofile = true
opt.swapfile = false
opt.hidden = true
opt.backup = false
opt.writebackup = false

opt.foldmethod = 'manual'
opt.visualbell = true
opt.errorbells = false

opt.smartcase = true
opt.ignorecase = true
opt.hlsearch = true
opt.incsearch = true

opt.shell = 'zsh'

opt.timeoutlen = 500
opt.linebreak = true
opt.autoindent = true
opt.breakindent = true
opt.breakindent = true

opt.laststatus = 2

opt.exrc = true
opt.secure = true
opt.termguicolors = true
opt.wrap = false

vim.g.vimsyn_embed = 'l' -- Highlight Lua code inside .vim files
