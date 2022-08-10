-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/jonatanbranting/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/jonatanbranting/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/jonatanbranting/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/jonatanbranting/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/jonatanbranting/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
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
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["better-escape.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/better-escape.nvim",
    url = "https://github.com/max397574/better-escape.nvim"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["bufresize.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/bufresize.nvim",
    url = "https://github.com/kwkarlwang/bufresize.nvim"
  },
  ["bullets.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/bullets.vim",
    url = "https://github.com/dkarter/bullets.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-commit"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-commit",
    url = "https://github.com/Dosx001/cmp-commit"
  },
  ["cmp-dap"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-dap",
    url = "https://github.com/rcarriga/cmp-dap"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["fern-git-status.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/fern-git-status.vim",
    url = "https://github.com/lambdalisue/fern-git-status.vim"
  },
  ["fern.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/fern.vim",
    url = "https://github.com/lambdalisue/fern.vim"
  },
  ["fidget.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["git-worktree.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/git-worktree.nvim",
    url = "https://github.com/ThePrimeagen/git-worktree.nvim"
  },
  ["github-nvim-theme"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["golden-ratio"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/golden-ratio",
    url = "https://github.com/roman/golden-ratio"
  },
  ["goto-preview"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/goto-preview",
    url = "https://github.com/rmagatti/goto-preview"
  },
  ["heirline.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/heirline.nvim",
    url = "https://github.com/rebelot/heirline.nvim"
  },
  ["hydra.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/hydra.nvim",
    url = "https://github.com/anuvyklack/hydra.nvim"
  },
  ["inc-rename.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/inc-rename.nvim",
    url = "https://github.com/smjonas/inc-rename.nvim"
  },
  ["keymap-layer.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/keymap-layer.nvim",
    url = "https://github.com/anuvyklack/keymap-layer.nvim"
  },
  ["leap-ast.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/leap-ast.nvim",
    url = "https://github.com/ggandor/leap-ast.nvim"
  },
  ["leap.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/jonatan-branting/lua-dev.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mini.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  neogen = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  neorg = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neorg",
    url = "https://github.com/nvim-neorg/neorg"
  },
  neoterm = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neoterm",
    url = "https://github.com/jonatan-branting/neoterm"
  },
  neotest = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest",
    url = "https://github.com/nvim-neotest/neotest"
  },
  ["neotest-jest"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest-jest",
    url = "https://github.com/haydenmeade/neotest-jest"
  },
  ["neotest-plenary"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest-plenary",
    url = "https://github.com/nvim-neotest/neotest-plenary"
  },
  ["neotest-python"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest-python",
    url = "https://github.com/nvim-neotest/neotest-python"
  },
  ["neotest-rspec"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest-rspec",
    url = "https://github.com/jonatan-branting/neotest-rspec"
  },
  ["neotest-vim-test"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/neotest-vim-test",
    url = "https://github.com/nvim-neotest/neotest-vim-test"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-better-n"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-better-n",
    url = "/Users/jonatanbranting/git/nvim-better-n"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/jonatan-branting/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/jonatan-branting/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-dd"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-dd",
    url = "https://gitlab.com/yorickpeterse/nvim-dd"
  },
  ["nvim-lint"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-lint",
    url = "https://github.com/mfussenegger/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-pqf.git"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-pqf.git",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\nÚ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\n\16visual_line\agS\vvisual\6S\20normal_cur_line\aSS\16normal_line\6S\vinsert\v<C-g>s\15normal_cur\ass\vnormal\6s\16insert_line\v<C-g>S\vchange\amc\vdelete\amd\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treehopper"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treehopper",
    url = "https://github.com/mfussenegger/nvim-treehopper"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-nodeobject"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treesitter-nodeobject",
    url = "https://github.com/jonatan-branting/nvim-treesitter-nodeobject"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-unception"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-unception",
    url = "https://github.com/samjwill/nvim-unception"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-yati"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["possession.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/possession.nvim",
    url = "https://github.com/jedrzejboczar/possession.nvim"
  },
  ["presenting.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/presenting.vim",
    url = "https://github.com/sotte/presenting.vim"
  },
  ["promise-async"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/promise-async",
    url = "https://github.com/kevinhwang91/promise-async"
  },
  ["refactoring.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/jonatan-branting/refactoring.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["shipwright.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/shipwright.nvim",
    url = "https://github.com/rktjmp/shipwright.nvim"
  },
  ["smart-splits.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/smart-splits.nvim",
    url = "https://github.com/mrjones2014/smart-splits.nvim"
  },
  ["splitjoin.vim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/sql.nvim",
    url = "https://github.com/tami5/sql.nvim"
  },
  ["stylish.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/stylish.nvim",
    url = "https://github.com/sunjon/stylish.nvim"
  },
  ["syntax-tree-surfer"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/syntax-tree-surfer",
    url = "https://github.com/ziontee113/syntax-tree-surfer"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["text-object-left-and-right"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/text-object-left-and-right",
    url = "https://github.com/vim-scripts/text-object-left-and-right"
  },
  tlib_vim = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/tlib_vim",
    url = "https://github.com/tomtom/tlib_vim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["treesitter-unit"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/treesitter-unit",
    url = "https://github.com/David-Kunz/treesitter-unit"
  },
  ["vim-asterisk"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-asterisk",
    url = "https://github.com/haya14busa/vim-asterisk"
  },
  ["vim-bundler"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-bundler",
    url = "https://github.com/tpope/vim-bundler"
  },
  ["vim-coffee-script"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-coffee-script",
    url = "https://github.com/kchmck/vim-coffee-script"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-dispatch-neovim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-dispatch-neovim",
    url = "https://github.com/jonatan-branting/vim-dispatch-neovim"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-haml"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-haml",
    url = "https://github.com/tpope/vim-haml"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-qf"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-rails"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-rails",
    url = "https://github.com/tpope/vim-rails"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-ruby"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby",
    url = "https://github.com/vim-ruby/vim-ruby"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-textobj-variable-segment"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/vim-textobj-variable-segment",
    url = "https://github.com/Julian/vim-textobj-variable-segment"
  },
  ["zenbones.nvim"] = {
    loaded = true,
    path = "/Users/jonatanbranting/.local/share/nvim/site/pack/packer/start/zenbones.nvim",
    url = "https://github.com/mcchrish/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\nÚ\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\fkeymaps\1\0\0\1\0\n\16visual_line\agS\vvisual\6S\20normal_cur_line\aSS\16normal_line\6S\vinsert\v<C-g>s\15normal_cur\ass\vnormal\6s\16insert_line\v<C-g>S\vchange\amc\vdelete\amd\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType eruby ++once lua require("packer.load")({'vim-haml'}, { ft = "eruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'vim-rails', 'vim-ruby', 'vim-bundler'}, { ft = "ruby" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]], true)
vim.cmd [[source /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]]
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby.vim]], false)
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]], true)
vim.cmd [[source /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]]
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-ruby/ftdetect/ruby_extra.vim]], false)
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], true)
vim.cmd [[source /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]]
time([[Sourcing ftdetect script at: /Users/jonatanbranting/.local/share/nvim/site/pack/packer/opt/vim-haml/ftdetect/haml.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
