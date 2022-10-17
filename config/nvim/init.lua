local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

DEFAULT_BORDERS = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }
DEFAULT_BORDERS = { topleft = '┏', horiz = '━', topright = '┓', vert = '┃', botright = '┛', botleft ='┗', vertleft = '┣', vertright = '┫', horizup = "┳", horizdown = "┻", verthoriz = "╋" }

DEFAULT_BORDERS = {  horiz = '━',  vert = '┃',   vertright = '┣', vertleft = '┫', horizdown = "┳", horizup = "┻", verthoriz = "╋" }
vim.opt.fillchars = DEFAULT_BORDERS
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
-- TODO move out 
-- for k, v in pairs(DEFAULT_BORDERS) do
--   vim.opt.fillchars = --vim.opt.fillchars .. k .. ":" .. v
-- end

vim.cmd [[packadd packer.nvim]]

-- TODO make this work better with lazy loading
require("packer").startup({
  function(use)
    use { "wbthomason/packer.nvim" }
    use { "smjonas/live-command.nvim",
      config = function()
        require("live-command").setup {
          -- defaults = {},
          commands = {
            Norm = { cmd = "norm" },
            G = { cmd = "g" },
          },
        }
      end,
    }
    use { "chaoren/vim-wordmotion" }
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("modules.neotree").setup()

        vim.keymap.set("n", "<leader>o", "<cmd>Neotree position=current reveal<cr>")
          -- function()
          -- -- require("neo-tree.command").execute({
          -- --   action = "show",
          -- --   source = "filesystem",
          -- --   position = "current",
          -- --   reveal = true,
          -- -- })
        -- end)
      end
    }
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-lua/plenary.nvim", run = "make" }
    use { "rcarriga/nvim-notify" }
    -- use { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async", config = function()
    --   vim.o.foldcolumn = '1'
    --   vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    --   vim.o.foldlevelstart = 99
    --   vim.o.foldenable = true
    --   require("ufo").setup()
    -- end}
    use { "jedrzejboczar/possession.nvim" }
    use { "projekt0n/github-nvim-theme" }
    use { "anuvyklack/windows.nvim",
      requires = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
      config = function()
        vim.o.winwidth = 10
        vim.o.winminwidth = 10
        vim.o.equalalways = false
        require("windows").setup()
      end
    }
    use { "catppuccin/nvim" }
    use { "ggandor/leap-ast.nvim" }
    use { "Julian/vim-textobj-variable-segment" }
    use { "gpanders/editorconfig.nvim" }
    -- use { "ibhagwan/fzf-lua" }
    use { "smjonas/inc-rename.nvim" }
    use { "rcarriga/cmp-dap" }
    use { "jonatan-branting/nvim-better-n" }
    use { "kana/vim-textobj-user" }
    use { "nvim-telescope/telescope.nvim" }
    use { "nvim-telescope/telescope-file-browser.nvim" }
    use { "jonatan-branting/nvim-treesitter-nodeobject" }
    use { "echasnovski/mini.nvim" }
    use { "L3MON4D3/LuaSnip" }
    use { "jonatan-branting/lua-dev.nvim" }
    use { "saadparwaiz1/cmp_luasnip" }
    -- use { "zbirenbaum/copilot.lua",
    --   requires = { { "zbirenbaum/copilot-cmp", module = "copilot_cmp" }},
    --   config = function()
    --     vim.defer_fn(function()
    --       require("copilot").setup({
    --         cmp = {
    --           enabled = true,
    --           method = "getCompletionsCycling",
    --         },
    --         panel = { -- no config options yet
    --           enabled = false,
    --         },
    --         ft_disable = {},
    --         plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
    --         server_opts_overrides = {},
    --       })
    --     end, 100)
    --   end, }
    use { "nvim-lua/popup.nvim" }
    use { "mrjones2014/smart-splits.nvim" }
    use { "nvim-neotest/neotest" }
    use { "nvim-neotest/neotest-plenary" }
    use { "nvim-neotest/neotest-python" }
    use { "nvim-neotest/neotest-vim-test" }
    use {
      'samodostal/copilot-client.lua',
      requires = {
        'zbirenbaum/copilot.lua', -- requires copilot.lua and plenary.nvim
        'nvim-lua/plenary.nvim'
      },
    }
    use { "haydenmeade/neotest-jest" }
    use { "jonatan-branting/neotest-rspec", as = "neotest-minitest"}
    use { "olimorris/neotest-rspec"}
    use { "j-hui/fidget.nvim" }
    use { "anuvyklack/hydra.nvim" }
    use { "anuvyklack/keymap-layer.nvim" }
    use { "yioneko/nvim-yati" }
    use { "kwkarlwang/bufresize.nvim" }
    use { "MunifTanjim/nui.nvim" }
    use { "sunjon/stylish.nvim" }
    use { "stevearc/dressing.nvim" }
    -- use { "kyazdani42/nvim-web-devicons" }
    use { "mfussenegger/nvim-treehopper" }
    use { "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({
          keymaps = {
            -- insert = "<C-g>s",
            -- insert_line = "<C-g>S",
            normal = "s",
            normal_cur = "ss",
            normal_line = "S",
            normal_cur_line = "SS",
            visual = "S",
            visual_line = "gS",
            delete = "ds",
            change = "cs",
          }
        })
      end
    }
    use { "andymass/vim-matchup" }
    use { "danymat/neogen" }
    use { "famiu/bufdelete.nvim" }
    use { "max397574/better-escape.nvim" }
    use { "rhysd/conflict-marker.vim" }
    use { "RRethy/nvim-treesitter-endwise" }
    use { "David-Kunz/treesitter-unit" }
    use { "jonatan-branting/refactoring.nvim" }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    use { "ray-x/lsp_signature.nvim" }
    use { "tomtom/tlib_vim" }
    use { "ziontee113/syntax-tree-surfer" }
    use { "nvim-neorg/neorg" }
    use { "jonatan-branting/vim-dispatch-neovim" }
    use { "RRethy/nvim-treesitter-textsubjects" }
    use { "rmagatti/goto-preview" }
    use { "folke/lsp-colors.nvim" }
    use { "rafamadriz/friendly-snippets" }
    use { "honza/vim-snippets" }
    use { "neovim/nvim-lspconfig" }
    use { "simrat39/rust-tools.nvim" }
    use { "hrsh7th/cmp-path" }
    use { "petertriho/cmp-git" }
    use { "Dosx001/cmp-commit" }
    use { "ray-x/cmp-treesitter" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-cmdline" }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/nvim-cmp" }
    use { "nvim-lua/lsp-status.nvim" }
    use { "onsails/lspkind-nvim" }
    use { "https://gitlab.com/yorickpeterse/nvim-dd" }
    use { "https://gitlab.com/yorickpeterse/nvim-pqf.git" }
    use { "sindrets/diffview.nvim" }
    use { "tpope/vim-rhubarb" }
    use { "lewis6991/gitsigns.nvim" }
    use { "tpope/vim-fugitive" }
    use { "ThePrimeagen/git-worktree.nvim", config = function()
      local worktree = require("git-worktree")
      worktree.setup({
        update_on_change = true,
        clearjumps_on_change = true
      })


      vim.api.nvim_create_user_command("GW", function(opts)
        local branch_name = opts.args

        require("git-worktree").create_worktree(branch_name, "develop", "origin")
      end, { nargs = 1 })
    end}
    use { "tami5/sql.nvim" }
    use { "kevinhwang91/nvim-bqf" }
    use { "kevinhwang91/promise-async" }
    use { "romainl/vim-qf" }
    use { "airblade/vim-rooter" }
    use { "JoosepAlviste/nvim-ts-context-commentstring" }
    use { "AndrewRadev/splitjoin.vim" }
    use { "haya14busa/vim-asterisk" }
    use { "junegunn/vim-easy-align" }
    use { "michaeljsmith/vim-indent-object" }
    use { "tpope/vim-repeat" }
    use { "tpope/vim-eunuch" }
    use { "tpope/vim-sleuth" }
    use { "rebelot/heirline.nvim" }
    use { "tpope/vim-rsi" }
    use { "tpope/vim-commentary" }
    use { "windwp/nvim-autopairs" }
    use { "samjwill/nvim-unception" }
    use { "antoinemadec/FixCursorHold.nvim" }
    use { "windwp/nvim-ts-autotag" }
    use { "dkarter/bullets.vim" }
    use {
      "jonatan-branting/neoterm",
      config = function()

        -- vim.cmd [[
        --   let g:neoterm_callbacks = {}
        --   function! g:neoterm_callbacks.before_exec()
        --     normal G
        --   endfunction
        -- ]]
      end
    }
    use { "vim-test/vim-test" }
    use { "jonatan-branting/nvim-dap" }
    use { "theHamsta/nvim-dap-virtual-text" }
    use { "tpope/vim-rails", ft="ruby" }
    use { "tpope/vim-haml", ft="eruby" }
    use { "kchmck/vim-coffee-script" }
    use { "vim-ruby/vim-ruby", ft="ruby"}
    use { "tpope/vim-bundler", ft="ruby" }
    use { "nvim-treesitter/playground" }
    use { "mfussenegger/nvim-lint" }
    use { "sotte/presenting.vim" }
    use { "folke/tokyonight.nvim" }

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    max_jobs = 10
  }
})

F = F or {}
function F.iter_buffer_range(buffer, range, func, opts)
  return require("utils").iter_buffer_range(buffer, range, func, opts)
end

vim.g.rooter_silent_chdir = 1
vim.g.ruby_indent_hanging_elements = 0
vim.g.ruby_indent_assignment_style = "variable"
vim.g.ruby_indent_block_style = "do"
vim.g.matchup_matchparen_offscreen = {}
vim.g["test#strategy"] = "neoterm"

-- require("old_vimscript")
require("modules.core_settings")
require("modules.mappings")

require("modules.dap")
require("modules.cmp")
require("modules._lsp")
require("modules.bqf")
require("modules.gitsigns")
require("modules.treesitter")
require("modules.autopairs")
require("modules.colorscheme")
require("modules._todo")
require("modules.neorg")
require("modules.possession")
require("modules.diagnostics")
require("modules.hydra")
require("modules.neotest")
require("modules.mini")
-- require("modules.fzf")
require("modules._telescope")
require("modules.popup").setup()

require("pqf").setup()
require("dd").setup()
require("dressing").setup()
require("inc_rename").setup()

require("fidget").setup({
  window = {
    blend = 10,
  },
  fmt = {
    stack_upwards = false
  }
})

require("better-n").setup {
  callbacks = {
    mapping_executed = function(_, key)
      if key == "n" then return end

      -- Clear highlighting, indicating that `n` will not goto the next
       -- highlighted search-term
      vim.cmd [[ nohl ]]
    end
  },
  mappings = {
    ["]h"] = {previous = "[h", next = "]h"},
    ["[h"] = {previous = "[h", next = "]h"},

    ["]m"] = {previous = "[m", next = "]m"},
    ["[m"] = {previous = "[m", next = "]m"},

    ["]r"] = {previous = "[r", next = "]r"},
    ["[r"] = {previous = "[r", next = "]r"},

    ["]a"] = {previous = "[a", next = "]a"},
    ["[a"] = {previous = "[a", next = "]a"},

    ["]f"] = {previous = "[f", next = "]f"},
    ["[f"] = {previous = "[f", next = "]f"},

    ["]n"] = {previous = "[n", next = "]n"},
    ["[n"] = {previous = "[n", next = "]n"},

    ["]d"] = {previous = "[d", next = "]d"},
    ["[d"] = {previous = "[d", next = "]d"},

    ["]q"] = {previous = "[q", next = "]q"},
    ["[q"] = {previous = "[q", next = "]q"},

    ["]b"] = {previous = "[b", next = "]b"},
    ["[b"] = {previous = "[b", next = "]b"},

    ["]c"] = {previous = "[c", next = "]c"},
    ["[c"] = {previous = "[c", next = "]c"},

    ["<leader>hn"] = {previous = "<leader>hp", next = "<leader>hn"},
    ["<leader>hp"] = {previous = "<leader>hp", next = "<leader>hn"},

    ["<leader>bn"] = {previous = "<leader>bp", next = "<leader>bn"},
    ["<leader>bp"] = {previous = "<leader>bp", next = "<leader>bn"},
  }
}

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

require("better_escape").setup {
  mapping = {"jk", "jj"},
  timeout = vim.o.timeoutlen,
  clear_empty_lines = false,
  keys = "<Esc>",
}

require("goto-preview").setup({
  width = 120,
  height = 15,
  border = {" ", "─" ,"┐", "│", "┘", "─", "└", "│"},
  default_mappings = false,
  debug = false,
  opacity = nil,
  resizing_mappings = false,
  post_open_hook = nil,
  focus_on_open = true,
  dismiss_on_move = false,
})

require("nvim-ts-autotag").setup({
  enabled = true,
  filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "eruby", "erb" },
})


require("neogen").setup({})
require("modules.ui.heirline")
require("modules.ex_normal_preview")
require("modules.select_mode").setup({})
require("modules.mouse_hover").setup()

require("mason").setup()
require("mason-lspconfig").setup()

local diagnostic_window = nil
vim.api.nvim_create_autocmd(
  "User", {
    pattern = "MouseHoverEnter",
    callback = function (args)
      vim.schedule(function()
        local row = args.data.position.line + 1
        local col = args.data.position.column

        local mouse_pos = vim.fn.getmousepos()
        local row = mouse_pos.line
        local col = mouse_pos.column
        print(row,col)

        local win_id = vim.diagnostic.open_float({
          scope = "cursor",
          pos = { row, col },
        })

        print("winid", win_id)
        diagnostic_window = vim.fn.win_id2win(win_id)
        if diagnostic_window == 0 then diagnostic_window = nil end
      end)
    end
  }
)
vim.api.nvim_create_autocmd(
  "User", {
    pattern = "MouseHoverLeave",
    callback = function (data)
      vim.schedule(function()
        if not diagnostic_window then return end

        vim.api.nvim_win_close(diagnostic_window, false)
      end)
    end
  }
)
