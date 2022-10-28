local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[ packadd packer.nvim ]]

require("packer").startup({
  function(use)
    use { "wbthomason/packer.nvim" }
    -- use { "smjonas/live-command.nvim",
    --   config = function()
    --     require("live-command").setup {
    --       -- defaults = {},
    --       commands = {
    --         Norm = { cmd = "norm!" },
    --         G = { cmd = "g" },
    --       },
    --     }
    --   end,
    -- }
    -- use { "chentoast/live.nvim",
    --   config = function()
    --     require("live").setup()
    --   end
    -- }
    use { "cbochs/grapple.nvim",
      config = function()
      end
    }
    use { "chaoren/vim-wordmotion" }
    use { "williamboman/mason.nvim",
      requires = {
        { "williamboman/mason-lspconfig.nvim" },
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end
    }
    use { "tamago324/lir.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
      },
      config = function()
        require("modules.lir")

        vim.keymap.set("n", "<leader>o", function()
          return "<cmd>edit " .. vim.fn.expand("%:h") .. "<cr>"
        end, { expr = true })
      end
    }
    -- use {
    --   "nvim-neo-tree/neo-tree.nvim",
    --   branch = "v2.x",
    --   requires = {
    --     "nvim-lua/plenary.nvim",
    --     "MunifTanjim/nui.nvim",
    --   },
    --   config = function()
    --     require("modules.neotree").setup()

    --     vim.keymap.set("n", "<leader>o", function()
    --       require("neo-tree.command").execute({
    --         action = "show",
    --         source = "filesystem",
    --         position = "current",
    --         reveal = true,
    --         toggle = true,
    --       })
    --     end)
    --   end
    -- }
    use { "nvim-lua/plenary.nvim", run = "make" }
    use { "rcarriga/nvim-notify" }
    use { "jedrzejboczar/possession.nvim",
      config = function()
        require("modules.possession")
      end
    }
    -- use { "anuvyklack/windows.nvim",
    --   requires = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    --   config = function()
    --     vim.o.winwidth = 10
    --     vim.o.winminwidth = 10
    --     require("windows").setup()
    --   end
    -- }
    use { "catppuccin/nvim" }
    -- use { "ggandor/leap-ast.nvim" }
    use { "Julian/vim-textobj-variable-segment" }
    use { "gpanders/editorconfig.nvim" }
    use { "smjonas/inc-rename.nvim",
      config = function()
        require("inc_rename").setup()
      end
    }
    use { "jonatan-branting/nvim-better-n",
      config = function()
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
      end
    }
    use { "kana/vim-textobj-user" }
    use { "ibhagwan/fzf-lua",
      config = function()
        require("modules.fzf")

        local fzf = require("fzf-lua" )

        vim.keymap.set("n", "<leader>f", function() fzf.grep({ search = "" }) end)
        vim.keymap.set("n", "<leader>l", function() fzf.resume() end)
        vim.keymap.set("n", "<leader>l", function() fzf.resume() end)
      end
    }
    use { "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-file-browser.nvim" },
      },
      config = function()
        require("modules._telescope")
      end
    }
    -- use { "jonatan-branting/nvim-treesitter-nodeobject" }
    use { "echasnovski/mini.nvim",
      config = function()
        require("modules.mini")
      end
    }
    use { "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end
    }
    use { "jonatan-branting/lua-dev.nvim" }
    use {
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("copilot").setup()
        end, 100)
      end,
    }
    use { "mrjones2014/smart-splits.nvim" }
    use { "nvim-neotest/neotest",
      requires = {
        { "jonatan-branting/neotest-rspec", as = "neotest-minitest"},
        { "nvim-neotest/neotest-plenary" },
        { "nvim-neotest/neotest-python" },
        { "nvim-neotest/neotest-vim-test" },
        { "haydenmeade/neotest-jest" },
        { "olimorris/neotest-rspec"},
      },
      config = function()
        require("modules.neotest")
      end
    }
    -- use {
    --   'samodostal/copilot-client.lua',
    --   requires = {
    --     'zbirenbaum/copilot.lua',
    --     'nvim-lua/plenary.nvim'
    --   },
    -- }
    use { "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({
          window = {
            blend = 10,
          },
          fmt = {
            stack_upwards = false
          }
        })
      end
    }
    use { "anuvyklack/hydra.nvim",
      requires = {
        "anuvyklack/keymap-layer.nvim",
      },
      after = {
        "gitsigns.nvim",
      },
      config = function()
        require("modules.hydra")
      end
    }
    use { "yioneko/nvim-yati" }
    use { "MunifTanjim/nui.nvim" }
    use { "stevearc/dressing.nvim",
      config = function()
        require("dressing").setup()
      end
    }
    -- use { "kyazdani42/nvim-web-devicons" }
    -- use { "mfussenegger/nvim-treehopper" }
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
            visual = "s",
            visual_line = "S",
            delete = "ds",
            change = "cs",
          }
        })
      end
    }
    use { "andymass/vim-matchup",
      config = function()
        vim.g.matchup_matchparen_offscreen = {}
      end
    }
    use { "danymat/neogen",
      config = function()
        require("neogen").setup({})
      end
    }
    use { "famiu/bufdelete.nvim" }
    use { "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup {
          mapping = {"jk", "jj"},
          timeout = vim.o.timeoutlen,
          clear_empty_lines = false,
          keys = "<esc>",
        }
      end
    }
    use { "rhysd/conflict-marker.vim" }
    use { "RRethy/nvim-treesitter-endwise" }
    use { "David-Kunz/treesitter-unit" }
    use { "jonatan-branting/refactoring.nvim" }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    -- use { "tomtom/tlib_vim" }
    use { "nvim-neorg/neorg",
      config = function()
        require("modules.neorg")
      end
    }
    use { "RRethy/nvim-treesitter-textsubjects" }
    -- use { "rmagatti/goto-preview",
    --   config = function()
    --     require("goto-preview").setup({
    --       width = 120,
    --       height = 15,
    --       border = {" ", "─" ,"┐", "│", "┘", "─", "└", "│"},
    --       default_mappings = false,
    --       debug = false,
    --       opacity = nil,
    --       resizing_mappings = false,
    --       post_open_hook = nil,
    --       focus_on_open = true,
    --       dismiss_on_move = false,
    --     })
    --   end
    -- }
    use { "folke/lsp-colors.nvim" }
    use { "rafamadriz/friendly-snippets" }
    use { "honza/vim-snippets" }
    use { "neovim/nvim-lspconfig" }
    use { "simrat39/rust-tools.nvim" }
    use { "hrsh7th/nvim-cmp",
      requires = {
        { "onsails/lspkind-nvim" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "rcarriga/cmp-dap" },
        { "petertriho/cmp-git" },
        { "Dosx001/cmp-commit" },
        { "ray-x/cmp-treesitter" },
        { "saadparwaiz1/cmp_luasnip" },
      },
      after = {
        "LuaSnip",
        "nvim-autopairs",
      },
      config = function()
        require("modules.cmp")
      end
    }
    use { "nvim-lua/lsp-status.nvim" }
    use { "https://gitlab.com/yorickpeterse/nvim-pqf.git",
      requires = {
        { "https://gitlab.com/yorickpeterse/nvim-dd" }
      },
      config = function()
        require("pqf").setup()
        require("dd").setup()
      end
    }
    use { "sindrets/diffview.nvim" }
    use { "tpope/vim-rhubarb" }
    use { "lewis6991/gitsigns.nvim",
      config = function()
        require("modules.gitsigns")
      end
    }
    use { "tpope/vim-fugitive" }
    -- use { "ThePrimeagen/git-worktree.nvim", config = function()
    --   local worktree = require("git-worktree")
    --   worktree.setup({
    --     update_on_change = true,
    --     clearjumps_on_change = true
    --   })


    --   vim.api.nvim_create_user_command("GW", function(opts)
    --     local branch_name = opts.args

    --     require("git-worktree").create_worktree(branch_name, "develop", "origin")
    --   end, { nargs = 1 })
    -- end}
    use { "tami5/sql.nvim" }
    use { "kevinhwang91/nvim-bqf",
      requires = {
        { "kevinhwang91/promise-async" }
      },
      config = function()
        require("modules.bqf")
      end
    }
    use { "romainl/vim-qf" }
    use { "airblade/vim-rooter",
      config = function()
        vim.g.rooter_silent_chdir = 1
      end
    }
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
    use { "windwp/nvim-autopairs",
      config = function()
        require("modules.autopairs")
      end
    }
    use { "samjwill/nvim-unception" }
    use { "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({
          enabled = true,
          filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "eruby", "erb" },
        })
      end
    }
    use { "dkarter/bullets.vim" }
    use { "akinsho/toggleterm.nvim",
      config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup({
          -- direction = function ()
          --   return 'vertical'
          -- end
        })

        vim.keymap.set("n", "ys", "<cmd>ToggleTerm<cr>")
      end
    }
    use { "vim-test/vim-test",
      config = function()
        vim.g["test#strategy"] = "toggleterm"
      end
    }
    use { "jonatan-branting/nvim-dap",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "theHamsta/nvim-dap-virtual-text" }
      },
      after = {
        "hydra.nvim",
      },
      config = function()
        require("modules.dap")
        local dap = require("dap")

        vim.keymap.set("n", "<leader>ds", dap.stop)
        vim.keymap.set("n", "<leader>dc", dap.continue)
        vim.keymap.set("n", "<leader>dk", dap.up)
        vim.keymap.set("n", "<leader>dj", dap.down)
        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>d-", dap.run_last)
        vim.keymap.set("n", "<leader>dr", function()
          dap.repl.open({}, 'vsplit')
        end)
        vim.keymap.set("n", "<leader>de", function()
          dap.set_exception_breakpoints({"all"})
        end)
      end
    }
    use { "tpope/vim-rails", ft="ruby" }
    use { "vim-ruby/vim-ruby",
      ft="ruby",
      config = function()
        vim.g.ruby_indent_hanging_elements = 0
        vim.g.ruby_indent_assignment_style = "variable"
        vim.g.ruby_indent_block_style = "do"
      end
    }
    use { "tpope/vim-bundler", ft="ruby" }
    use { "nvim-treesitter/playground" }
    use { "mfussenegger/nvim-lint" }

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

require("modules.core_settings")

vim.api.nvim_create_autocmd("VimEnter",
  {
    callback = function()
      require("modules.mappings")

      require("modules._lsp")
      require("modules._todo")
      require("modules.treesitter")
      require("modules.colorscheme")
      require("modules.diagnostics")

      require("modules.popup").setup()
      require("modules.visual_command").setup()
      -- require("modules.select_mode").setup()
      -- require("modules.mouse_hover").setup()

      require("modules.ui.heirline")
    end
  }
)

vim.api.nvim_create_autocmd("BufWritePost",
  {
    pattern = vim.fn.expand("~/git/dotfiles/config/nvim/init.lua"),
    callback = function(args)
      vim.cmd.luafile(args.file)
      vim.cmd("PackerCompile")
    end
  }
)

local reload = require("plenary.reload")
vim.api.nvim_create_autocmd("BufWritePost",
  {
    pattern = vim.fn.expand("~/git/dotfiles/config/nvim/") .. "**/*.lua",
    callback = function(args)
      reload.reload_module(args.file)
      vim.cmd.luafile(args.file)
    end
  }
)

-- local diagnostic_window = nil
-- vim.api.nvim_create_autocmd(
--   "User", {
--     pattern = "MouseHoverEnter",
--     callback = function (args)
--       vim.schedule(function()
--         local row = args.data.position.line + 1
--         local col = args.data.position.column

--         local mouse_pos = vim.fn.getmousepos()
--         local row = mouse_pos.line
--         local col = mouse_pos.column
--         print(row,col)

--         local win_id = vim.diagnostic.open_float({
--           -- scope = "cursor",
--           pos = { row, col },
--           row = row,
--           col = col,
--           relative = "win"
--         })

--         -- print("winid", win_id)
--         diagnostic_window = vim.fn.win_id2win(win_id)
--         if diagnostic_window == 0 then diagnostic_window = nil end
--       end)
--     end
--   }
-- )
-- )
-- vim.api.nvim_create_autocmd(
--   "User", {
--     pattern = "MouseHoverLeave",
--     callback = function (data)
--       vim.schedule(function()
--         if not diagnostic_window then return end

--         vim.api.nvim_win_close(diagnostic_window, false)
--       end)
--     end
--   }
-- )
