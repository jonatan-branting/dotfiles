-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/nonah/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/nonah/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/nonah/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/nonah/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/nonah/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    after = { "nvim-cmp" },
    config = { "\27LJ\2\n\127\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\"luasnip.loaders.from_snipmate\14lazy_load luasnip.loaders.from_vscode\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["better-escape.nvim"] = {
    config = { "\27LJ\2\n£\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\3=\3\t\2B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\0\2\tkeys\n<esc>\22clear_empty_lines\1\1\3\0\0\ajk\ajj\nsetup\18better_escape\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bullets.vim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/bullets.vim",
    url = "https://github.com/dkarter/bullets.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-commit"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-commit",
    url = "https://github.com/Dosx001/cmp-commit"
  },
  ["cmp-dap"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-dap",
    url = "https://github.com/rcarriga/cmp-dap"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["copilot.lua"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fcopilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\2\ns\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\bfmt\1\0\1\18stack_upwards\1\vwindow\1\0\0\1\0\1\nblend\3\n\nsetup\vfidget\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzf-lua"] = {
    config = { "\27LJ\2\n-\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\0\1\vsearch\5\tgrep \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\vresume \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\vresumeø\1\1\0\6\0\f\0\0296\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0003\5\b\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0003\5\n\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0003\5\v\0B\1\4\0012\0\0ÄK\0\1\0\0\0\14<leader>l\0\14<leader>f\6n\bset\vkeymap\bvim\ffzf-lua\16modules.fzf\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    after = { "hydra.nvim" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21modules.gitsigns\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["grapple.nvim"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/grapple.nvim",
    url = "https://github.com/cbochs/grapple.nvim"
  },
  ["heirline.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/heirline.nvim",
    url = "https://github.com/rebelot/heirline.nvim"
  },
  ["hydra.nvim"] = {
    after = { "nvim-dap" },
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18modules.hydra\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/hydra.nvim",
    url = "https://github.com/anuvyklack/hydra.nvim"
  },
  ["inc-rename.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15inc_rename\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/inc-rename.nvim",
    url = "https://github.com/smjonas/inc-rename.nvim"
  },
  ["keymap-layer.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/keymap-layer.nvim",
    url = "https://github.com/anuvyklack/keymap-layer.nvim"
  },
  ["lir.nvim"] = {
    config = { "\27LJ\2\nM\0\0\4\0\6\0\t'\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0B\1\2\2'\2\5\0&\0\2\0L\0\2\0\t<cr>\b%:h\vexpand\afn\bvim\15<cmd>edit p\1\0\6\0\t\0\f6\0\0\0'\2\1\0B\0\2\0016\0\2\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0003\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\texpr\2\0\14<leader>o\6n\bset\vkeymap\bvim\16modules.lir\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/lir.nvim",
    url = "https://github.com/tamago324/lir.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/jonatan-branting/lua-dev.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\nW\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20mason-lspconfig\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17modules.mini\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  neorg = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18modules.neorg\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  neotest = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20modules.neotest\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-jest"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-jest",
    url = "https://github.com/haydenmeade/neotest-jest"
  },
  ["neotest-minitest"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-minitest",
    url = "https://github.com/jonatan-branting/neotest-rspec"
  },
  ["neotest-plenary"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-plenary",
    url = "https://github.com/nvim-neotest/neotest-plenary"
  },
  ["neotest-python"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-python",
    url = "https://github.com/nvim-neotest/neotest-python"
  },
  ["neotest-rspec"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-rspec",
    url = "https://github.com/olimorris/neotest-rspec"
  },
  ["neotest-vim-test"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/neotest-vim-test",
    url = "https://github.com/nvim-neotest/neotest-vim-test"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  nvim = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-autopairs"] = {
    after = { "nvim-cmp" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22modules.autopairs\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-better-n"] = {
    config = { "\27LJ\2\n8\0\2\5\0\4\0\b\a\1\0\0X\2\1ÄK\0\1\0006\2\1\0009\2\2\2'\4\3\0B\2\2\1K\0\1\0\v nohl \bcmd\bvim\6nê\b\1\0\5\0:\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\0035\4\27\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\0035\4%\0=\4&\0035\4'\0=\4(\0035\4)\0=\4*\0035\4+\0=\4,\0035\4-\0=\4.\0035\4/\0=\0040\0035\0041\0=\0042\0035\0043\0=\0044\0035\0045\0=\0046\0035\0047\0=\0048\3=\0039\2B\0\2\1K\0\1\0\rmappings\15<leader>bp\1\0\2\rprevious\15<leader>bp\tnext\15<leader>bn\15<leader>bn\1\0\2\rprevious\15<leader>bp\tnext\15<leader>bn\15<leader>hp\1\0\2\rprevious\15<leader>hp\tnext\15<leader>hn\15<leader>hn\1\0\2\rprevious\15<leader>hp\tnext\15<leader>hn\a[c\1\0\2\rprevious\a[c\tnext\a]c\a]c\1\0\2\rprevious\a[c\tnext\a]c\a[b\1\0\2\rprevious\a[b\tnext\a]b\a]b\1\0\2\rprevious\a[b\tnext\a]b\a[q\1\0\2\rprevious\a[q\tnext\a]q\a]q\1\0\2\rprevious\a[q\tnext\a]q\a[d\1\0\2\rprevious\a[d\tnext\a]d\a]d\1\0\2\rprevious\a[d\tnext\a]d\a[n\1\0\2\rprevious\a[n\tnext\a]n\a]n\1\0\2\rprevious\a[n\tnext\a]n\a[f\1\0\2\rprevious\a[f\tnext\a]f\a]f\1\0\2\rprevious\a[f\tnext\a]f\a[a\1\0\2\rprevious\a[a\tnext\a]a\a]a\1\0\2\rprevious\a[a\tnext\a]a\a[r\1\0\2\rprevious\a[r\tnext\a]r\a]r\1\0\2\rprevious\a[r\tnext\a]r\a[m\1\0\2\rprevious\a[m\tnext\a]m\a]m\1\0\2\rprevious\a[m\tnext\a]m\a[h\1\0\2\rprevious\a[h\tnext\a]h\a]h\1\0\0\1\0\2\rprevious\a[h\tnext\a]h\14callbacks\1\0\0\21mapping_executed\1\0\0\0\nsetup\rbetter-n\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-better-n",
    url = "https://github.com/jonatan-branting/nvim-better-n"
  },
  ["nvim-bqf"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16modules.bqf\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16modules.cmp\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n6\0\0\4\1\3\0\a-\0\0\0009\0\0\0009\0\1\0004\2\0\0'\3\2\0B\0\3\1K\0\1\0\0¿\vvsplit\topen\trepl?\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\2\0\0\ball\30set_exception_breakpointsª\3\1\0\6\0\23\0@6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0009\5\b\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0009\5\n\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\v\0009\5\f\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\r\0009\5\14\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\15\0009\5\16\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\17\0009\5\18\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\19\0003\5\20\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\21\0003\5\22\0B\1\4\0012\0\0ÄK\0\1\0\0\15<leader>de\0\15<leader>dr\rrun_last\15<leader>d-\22toggle_breakpoint\15<leader>dt\tdown\15<leader>dj\aup\15<leader>dk\rcontinue\15<leader>dc\tstop\15<leader>ds\6n\bset\vkeymap\bvim\bdap\16modules.dap\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/jonatan-branting/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-dd"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-dd",
    url = "https://gitlab.com/yorickpeterse/nvim-dd"
  },
  ["nvim-lint"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-lint",
    url = "https://github.com/mfussenegger/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-pqf.git"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\add\nsetup\bpqf\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n∏\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\b\16visual_line\6S\20normal_cur_line\aSS\vdelete\ads\16normal_line\6S\vchange\acs\15normal_cur\ass\vnormal\6s\vvisual\6s\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14filetypes\1\t\0\0\thtml\15javascript\20javascriptreact\20typescriptreact\vsvelte\bvue\neruby\berb\1\0\1\fenabled\2\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-unception"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-unception",
    url = "https://github.com/samjwill/nvim-unception"
  },
  ["nvim-yati"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["possession.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23modules.possession\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/possession.nvim",
    url = "https://github.com/jedrzejboczar/possession.nvim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/jonatan-branting/refactoring.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/sql.nvim",
    url = "https://github.com/tami5/sql.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23modules._telescope\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nÄ\1\0\0\6\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0'\5\b\0B\1\4\1K\0\1\0\24<cmd>ToggleTerm<cr>\ays\6n\bset\vkeymap\bvim\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["treesitter-unit"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/treesitter-unit",
    url = "https://github.com/David-Kunz/treesitter-unit"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-asterisk",
    url = "https://github.com/haya14busa/vim-asterisk"
  },
  ["vim-bundler"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-bundler",
    url = "https://github.com/tpope/vim-bundler"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-matchup"] = {
    config = { "\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-rails"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-rooter"] = {
    config = { "\27LJ\2\n5\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\24rooter_silent_chdir\6g\bvim\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-ruby"] = {
    config = { "\27LJ\2\nü\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\1\0'\1\4\0=\1\3\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0K\0\1\0\ado\28ruby_indent_block_style\rvariable!ruby_indent_assignment_style!ruby_indent_hanging_elements\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby",
    url = "https://github.com/vim-ruby/vim-ruby"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\n:\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15toggleterm\18test#strategy\6g\bvim\0" },
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment",
    url = "https://github.com/Julian/vim-textobj-variable-segment"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/Users/nonah/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21modules.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23modules._telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-rooter
time([[Config for vim-rooter]], true)
try_loadstring("\27LJ\2\n5\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\24rooter_silent_chdir\6g\bvim\0", "config", "vim-rooter")
time([[Config for vim-rooter]], false)
-- Config for: nvim-pqf.git
time([[Config for nvim-pqf.git]], true)
try_loadstring("\27LJ\2\nH\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\add\nsetup\bpqf\frequire\0", "config", "nvim-pqf.git")
time([[Config for nvim-pqf.git]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n∏\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\b\16visual_line\6S\20normal_cur_line\aSS\vdelete\ads\16normal_line\6S\vchange\acs\15normal_cur\ass\vnormal\6s\vvisual\6s\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: possession.nvim
time([[Config for possession.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23modules.possession\frequire\0", "config", "possession.nvim")
time([[Config for possession.nvim]], false)
-- Config for: neorg
time([[Config for neorg]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18modules.neorg\frequire\0", "config", "neorg")
time([[Config for neorg]], false)
-- Config for: nvim-better-n
time([[Config for nvim-better-n]], true)
try_loadstring("\27LJ\2\n8\0\2\5\0\4\0\b\a\1\0\0X\2\1ÄK\0\1\0006\2\1\0009\2\2\2'\4\3\0B\2\2\1K\0\1\0\v nohl \bcmd\bvim\6nê\b\1\0\5\0:\0=6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0003\4\3\0=\4\5\3=\3\a\0025\3\t\0005\4\b\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0035\4\21\0=\4\22\0035\4\23\0=\4\24\0035\4\25\0=\4\26\0035\4\27\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\0035\4%\0=\4&\0035\4'\0=\4(\0035\4)\0=\4*\0035\4+\0=\4,\0035\4-\0=\4.\0035\4/\0=\0040\0035\0041\0=\0042\0035\0043\0=\0044\0035\0045\0=\0046\0035\0047\0=\0048\3=\0039\2B\0\2\1K\0\1\0\rmappings\15<leader>bp\1\0\2\rprevious\15<leader>bp\tnext\15<leader>bn\15<leader>bn\1\0\2\rprevious\15<leader>bp\tnext\15<leader>bn\15<leader>hp\1\0\2\rprevious\15<leader>hp\tnext\15<leader>hn\15<leader>hn\1\0\2\rprevious\15<leader>hp\tnext\15<leader>hn\a[c\1\0\2\rprevious\a[c\tnext\a]c\a]c\1\0\2\rprevious\a[c\tnext\a]c\a[b\1\0\2\rprevious\a[b\tnext\a]b\a]b\1\0\2\rprevious\a[b\tnext\a]b\a[q\1\0\2\rprevious\a[q\tnext\a]q\a]q\1\0\2\rprevious\a[q\tnext\a]q\a[d\1\0\2\rprevious\a[d\tnext\a]d\a]d\1\0\2\rprevious\a[d\tnext\a]d\a[n\1\0\2\rprevious\a[n\tnext\a]n\a]n\1\0\2\rprevious\a[n\tnext\a]n\a[f\1\0\2\rprevious\a[f\tnext\a]f\a]f\1\0\2\rprevious\a[f\tnext\a]f\a[a\1\0\2\rprevious\a[a\tnext\a]a\a]a\1\0\2\rprevious\a[a\tnext\a]a\a[r\1\0\2\rprevious\a[r\tnext\a]r\a]r\1\0\2\rprevious\a[r\tnext\a]r\a[m\1\0\2\rprevious\a[m\tnext\a]m\a]m\1\0\2\rprevious\a[m\tnext\a]m\a[h\1\0\2\rprevious\a[h\tnext\a]h\a]h\1\0\0\1\0\2\rprevious\a[h\tnext\a]h\14callbacks\1\0\0\21mapping_executed\1\0\0\0\nsetup\rbetter-n\frequire\0", "config", "nvim-better-n")
time([[Config for nvim-better-n]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
try_loadstring("\27LJ\2\n-\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\0\1\vsearch\5\tgrep \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\vresume \0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\0¿\vresumeø\1\1\0\6\0\f\0\0296\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0003\5\b\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0003\5\n\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0003\5\v\0B\1\4\0012\0\0ÄK\0\1\0\0\0\14<leader>l\0\14<leader>f\6n\bset\vkeymap\bvim\ffzf-lua\16modules.fzf\frequire\0", "config", "fzf-lua")
time([[Config for fzf-lua]], false)
-- Config for: neotest
time([[Config for neotest]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20modules.neotest\frequire\0", "config", "neotest")
time([[Config for neotest]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22modules.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-bqf
time([[Config for nvim-bqf]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16modules.bqf\frequire\0", "config", "nvim-bqf")
time([[Config for nvim-bqf]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0004\1\0\0=\1\2\0K\0\1\0!matchup_matchparen_offscreen\6g\bvim\0", "config", "vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
try_loadstring("\27LJ\2\ns\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\bfmt\1\0\1\18stack_upwards\1\vwindow\1\0\0\1\0\1\nblend\3\n\nsetup\vfidget\frequire\0", "config", "fidget.nvim")
time([[Config for fidget.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\nW\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\20mason-lspconfig\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: better-escape.nvim
time([[Config for better-escape.nvim]], true)
try_loadstring("\27LJ\2\n£\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0026\3\6\0009\3\a\0039\3\b\3=\3\t\2B\0\2\1K\0\1\0\ftimeout\15timeoutlen\6o\bvim\fmapping\1\0\2\tkeys\n<esc>\22clear_empty_lines\1\1\3\0\0\ajk\ajj\nsetup\18better_escape\frequire\0", "config", "better-escape.nvim")
time([[Config for better-escape.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nÄ\1\0\0\6\0\t\0\0146\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0'\5\b\0B\1\4\1K\0\1\0\24<cmd>ToggleTerm<cr>\ays\6n\bset\vkeymap\bvim\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n\127\0\0\3\0\4\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\"luasnip.loaders.from_snipmate\14lazy_load luasnip.loaders.from_vscode\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: grapple.nvim
time([[Config for grapple.nvim]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "grapple.nvim")
time([[Config for grapple.nvim]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n®\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\14filetypes\1\t\0\0\thtml\15javascript\20javascriptreact\20typescriptreact\vsvelte\bvue\neruby\berb\1\0\1\fenabled\2\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: inc-rename.nvim
time([[Config for inc-rename.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\15inc_rename\frequire\0", "config", "inc-rename.nvim")
time([[Config for inc-rename.nvim]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17modules.mini\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: lir.nvim
time([[Config for lir.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\4\0\6\0\t'\0\0\0006\1\1\0009\1\2\0019\1\3\1'\3\4\0B\1\2\2'\2\5\0&\0\2\0L\0\2\0\t<cr>\b%:h\vexpand\afn\bvim\15<cmd>edit p\1\0\6\0\t\0\f6\0\0\0'\2\1\0B\0\2\0016\0\2\0009\0\3\0009\0\4\0'\2\5\0'\3\6\0003\4\a\0005\5\b\0B\0\5\1K\0\1\0\1\0\1\texpr\2\0\14<leader>o\6n\bset\vkeymap\bvim\16modules.lir\frequire\0", "config", "lir.nvim")
time([[Config for lir.nvim]], false)
-- Config for: vim-test
time([[Config for vim-test]], true)
try_loadstring("\27LJ\2\n:\0\0\2\0\4\0\0056\0\0\0009\0\1\0'\1\3\0=\1\2\0K\0\1\0\15toggleterm\18test#strategy\6g\bvim\0", "config", "vim-test")
time([[Config for vim-test]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd hydra.nvim ]]

-- Config for: hydra.nvim
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18modules.hydra\frequire\0", "config", "hydra.nvim")

vim.cmd [[ packadd nvim-dap ]]

-- Config for: nvim-dap
try_loadstring("\27LJ\2\n6\0\0\4\1\3\0\a-\0\0\0009\0\0\0009\0\1\0004\2\0\0'\3\2\0B\0\3\1K\0\1\0\0¿\vvsplit\topen\trepl?\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\0¿\1\2\0\0\ball\30set_exception_breakpointsª\3\1\0\6\0\23\0@6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0026\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0009\5\b\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\t\0009\5\n\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\v\0009\5\f\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\r\0009\5\14\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\15\0009\5\16\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\17\0009\5\18\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\19\0003\5\20\0B\1\4\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\21\0003\5\22\0B\1\4\0012\0\0ÄK\0\1\0\0\15<leader>de\0\15<leader>dr\rrun_last\15<leader>d-\22toggle_breakpoint\15<leader>dt\tdown\15<leader>dj\aup\15<leader>dk\rcontinue\15<leader>dc\tstop\15<leader>ds\6n\bset\vkeymap\bvim\bdap\16modules.dap\frequire\0", "config", "nvim-dap")

vim.cmd [[ packadd nvim-cmp ]]

-- Config for: nvim-cmp
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16modules.cmp\frequire\0", "config", "nvim-cmp")

time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'vim-ruby', 'vim-bundler', 'vim-rails'}, { ft = "ruby" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'copilot.lua'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]], true)
vim.cmd [[source /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]]
time([[Sourcing ftdetect script at: /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]], false)
time([[Sourcing ftdetect script at: /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]], true)
vim.cmd [[source /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]]
time([[Sourcing ftdetect script at: /Users/nonah/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
