local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.opt.shell = "zsh"

vim.cmd [[ packadd packer.nvim ]]

require("packer").startup({
  function(use)
    use { "wbthomason/packer.nvim" }

    use({
      "dnlhc/glance.nvim",
      config = function()
        local glance = require('glance')
        local actions = glance.actions

        glance.setup({
          mappings = {
            list = {
              ['j'] = actions.next,
              ['k'] = actions.previous,
              ['<Down>'] = actions.next,
              ['<Up>'] = actions.previous,
              ['<Tab>'] = actions.next_location,
              ['<S-Tab>'] = actions.previous_location,
              ['<C-u>'] = actions.preview_scroll_win(5),
              ['<C-d>'] = actions.preview_scroll_win(-5),
              ['v'] = actions.jump_vsplit,
              ['s'] = actions.jump_split,
              ['t'] = actions.jump_tab,
              ['<CR>'] = actions.jump,
              ['o'] = actions.jump,
              ['l'] = actions.jump,
              ['gr'] = actions.enter_win('preview'),
              ['q'] = actions.close,
              ['Q'] = actions.close,
              ['<Esc>'] = actions.close,
            },
            preview = {
              ['Q'] = actions.close,
              ['<Tab>'] = actions.next_location,
              ['<S-Tab>'] = actions.previous_location,
              ['gr'] = actions.enter_win('list'),
            },
          },
          hooks = {
            before_open = function(results, open, jump, method)
              if #results == 1 then
                jump(results[1])
              else
                open(results)
              end
            end,
          }
        })

        vim.keymap.set("n", "gd", "<CMD>Glance definitions<CR>")
        vim.keymap.set("n", "gr", "<CMD>Glance references<CR>")
        vim.keymap.set("n", "gy", "<CMD>Glance type_definitions<CR>")
        vim.keymap.set("n", "gm", "<CMD>Glance implementations<CR>")

      end,
    })
    use {
      "nvim-zh/colorful-winsep.nvim",
      commit = "bb06c86",
      config = function()
        require("colorful-winsep").setup({
          highlight = {
            guibg = "none",
            guifg = "#957CC6",
            gui = "bold",
          },
          interval = 30,
          no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
          symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
          close_event = function()
          end,
          create_event = function()
          end,
        })
      end
    }
    use { "lewis6991/satellite.nvim",
      config = function()
        require("satellite").setup({
          current_only = false,
        })
      end
    }
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
    use { "lambdalisue/fern.vim",
      config = function()
        vim.g["fern#hide_cursor"] = 1
        vim.g["fern#keepjumps_on_edit"] = 0
        vim.g["fern#keepalt_on_edit"] = 1

        vim.keymap.set("n", "<leader>o", function()
          return "<cmd>Fern . -reveal=%<cr>"
        end, { expr = true })
      end
    }
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
    use { "nvim-lua/plenary.nvim", run = "make" }
    use { "jedrzejboczar/possession.nvim",
      config = function()
        require("modules.possession")
      end
    }
    use { "catppuccin/nvim" }
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
    use {
      "nvim-neorg/neorg",
      config = function()
        require('neorg').setup {
          load = {
            ["core.defaults"] = {}
          }
        }
      end,
      requires = "nvim-lua/plenary.nvim"
    }
    use { "kana/vim-textobj-user" }
    use { "ibhagwan/fzf-lua",
      config = function()
        require("modules.fzf")

        local fzf = require("fzf-lua" )

        vim.keymap.set("n", "<leader>f", function() fzf.grep({ search = "" }) end)
        vim.keymap.set("n", "<leader>p", function() fzf.files() end)
        vim.keymap.set("n", "<leader>i", function() fzf.files({ cwd = vim.fn.expand("%:h") }) end)
        vim.keymap.set("n", "<leader>e", function() fzf.buffers() end)
        vim.keymap.set("n", "<leader>m", function() fzf.old_files() end)
        vim.keymap.set("n", "gw", function() fzf.grep_cword() end)
        vim.keymap.set("n", "gW", function() fzf.grep_cWORD() end)
      end
    }
    use { "echasnovski/mini.nvim",
      config = function()
        require("modules.mini")

        vim.keymap.set("n", "<leader>bh", require("mini.starter").open)
      end
    }
    use {
      "smjonas/snippet-converter.nvim",
      -- SnippetConverter uses semantic versioning. Example: use version = "1.*" to avoid breaking changes on version 1.
      -- Uncomment the next line to follow stable releases only.
      -- tag = "*",
      config = function()
        local template = {
          -- name = "t1", (optionally give your template a name to refer to it in the `ConvertSnippets` command)
          sources = {
            ultisnips = {
              -- Add snippets from (plugin) folders or individual files on your runtimepath...
              "./vim-snippets/UltiSnips",
              "./latex-snippets/tex.snippets",
              -- ...or use absolute paths on your system.
              vim.fn.stdpath("config") .. "/UltiSnips",
            },
            snipmate = {
              "vim-snippets/snippets",
            },
          },
          output = {
            -- Specify the output formats and paths
            vscode_luasnip = {
              vim.fn.stdpath("config") .. "/luasnip_snippets",
            },
          },
        }
        require("snippet_converter").setup {
          templates = { template },
          -- To change the default settings (see configuration section in the documentation)
          -- settings = {},
        }
      end
    }
    use { "L3MON4D3/LuaSnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_snipmate").lazy_load()
      end
    }
    use { "folke/neodev.nvim",
      config = function()
        require("neodev").setup({
          library = {
            enabled = true,
            runtime = true,
            types = true,
            plugins = true,
          },
          setup_jsonls = true,
          lspconfig = true,
          debug = false,
          experimental = {
            pathStrict = true
          }
        })
      end
    }
    use {
      "zbirenbaum/copilot.lua",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("copilot").setup({
            panel = {
              enabled = false,
            },
            suggestion = {
              enabled = true,
              auto_trigger = true,
              debounce = 75,
              keymap = {
                accept = "<c-e>",
                next = "<c-n>",
                prev = "<c-p>",
                dismiss = "<C-]>",
              },
            },
            filetypes = {
              yaml = false,
              markdown = false,
              help = false,
              gitcommit = false,
              gitrebase = false,
              hgcommit = false,
              norg = false,
              svn = false,
              cvs = false,
              ruby = true,
              ["."] = false,
            },
            copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/nvm/v16.17.1/bin/node",
            plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
            server_opts_overrides = {
              advanced = {
                length = 1,
              }
            },
          })
        end, 100)

        local suggestion = require("copilot.suggestion")

          -- if suggestion.is_visible() then
          -- vim.keymap.set("i", "<c-e>", function()
          --   suggestion.accept()
          -- else
          --   return "<c-o>g$"
          -- end
        -- end, { expr = true })

        vim.keymap.set("i", "<c-p>", function()
          suggestion.prev()
        end)

        vim.keymap.set("i", "<c-n>", function()
          suggestion.next()
        end)
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

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "lua",
          callback = function(args)
            vim.keymap.set("n", "<leader>tn", function() require("neotest").run.run() end, { buffer = args.buf })
            vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { buffer = args.buf })
          end
        })
      end
    }
    use { "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({
          window = {
            blend = 100,
            relative = "editor",
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
    use { "rhysd/conflict-marker.vim" }
    use { "RRethy/nvim-treesitter-endwise" }
    use { "David-Kunz/treesitter-unit" }
    use { "ThePrimeagen/refactoring.nvim",
      config = function()
        require("refactoring").setup()

        vim.keymap.set("v", "<leader>rr", require('refactoring').select_refactor)
      end
    }
    use { "nvim-treesitter/nvim-treesitter" }
    use { "nvim-treesitter/nvim-treesitter-textobjects" }
    use { "RRethy/nvim-treesitter-textsubjects" }
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
    use({
      "andrewferrier/wrapping.nvim",
      config = function()
        require("wrapping").setup()
      end,
    })
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
    use({
      'Wansmer/treesj',
      requires = { 'nvim-treesitter' },
      config = function()
        local langs = require('treesj.langs')['presets']

        require('treesj').setup({
          use_default_keymaps = false,
          check_syntax_error = true,

          -- If line after join will be longer than max value,
          -- node will not be formatted
          max_join_length = 120,

          -- hold|start|end:
          -- hold - cursor follows the node/place on which it was called
          -- start - cursor jumps to the first symbol of the node being formatted
          -- end - cursor jumps to the last symbol of the node being formatted
          cursor_behavior = 'hold',

          -- Notify about possible problems or not
          notify = false,
          langs = {

          },
        })

        -- Fallback to SplitJoin
        vim.api.nvim_create_autocmd({ 'FileType' }, {
          pattern = '*',
          callback = function()
            local opts = { buffer = true }
            if langs[vim.bo.filetype] then
              vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
              vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
            else
              vim.keymap.set('n', 'gS', '<Cmd>SplitjoinSplit<CR>', opts)
              vim.keymap.set('n', 'gJ', '<Cmd>SplitjoinJoin<CR>', opts)
            end
          end,
        })
      end,
    })
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
    use { "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup({
          enabled = true,
          filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "eruby", "erb" },
        })
      end
    }
    use { "dkarter/bullets.vim" }
    use { "vim-test/vim-test",
      config = function()
        local term_integrations = require("modules.term.integrations")

        term_integrations.set_vim_test_strategy()
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
    use { "tpope/vim-rails", ft = "ruby" }
    use { "vim-ruby/vim-ruby",
      ft = "ruby",
      config = function()
        vim.g.ruby_indent_hanging_elements = 0
        vim.g.ruby_indent_assignment_style = "variable"
        vim.g.ruby_indent_block_style = "do"
      end
    }
    use { "tpope/vim-bundler", ft = "ruby" }
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
require("modules.colorscheme")

vim.api.nvim_create_autocmd("VimEnter",
  {
    callback = function()
      require("modules.mappings")

      require("modules._lsp")
      require("modules._todo")
      require("modules.treesitter")
      require("modules.diagnostics")

      require("modules.popup").setup()
      require("modules.visual_command").setup()
      -- require("modules.select_mode").setup()
      require("modules.mouse_hover").setup()

      require("modules.ui.heirline")

      require("modules.focus_window_on_hover")

      require("modules.term").setup()

      vim.keymap.set("n", "<leader>l", function ()
        require("modules.term")
          :get_terminal()
          :toggle()
      end)

      vim.keymap.set("n", "<leader>x", function()
        -- TODO we can likely expand this to language specific mappings, which might wrap things
        -- to auto-monkey-patch stuff in Ruby, for example, by using Treesitter

        require("modules.term")
          :get_terminal()
          :send(vim.fn.getline("."))
      end)
    end
  }
)

vim.keymap.set("n", "<leader>l", function ()
  require("modules.term"):get_terminal():toggle()
end)

local group = vim.api.nvim_create_augroup("AutoReload", {})

vim.api.nvim_create_autocmd("BufWritePost",
  {
    pattern = vim.fn.expand("config/nvim/init.lua"),
    group = group,
    callback = function(args)
      vim.cmd.luafile(args.file)
      vim.cmd("PackerCompile")

      vim.schedule(function()
        print("reloaded:", args.file)
      end)
    end
  }
)

local reload = require("plenary.reload")
vim.api.nvim_create_autocmd("BufWritePost",
  {
    pattern = vim.fn.expand("~/git/dotfiles/config/nvim/") .. "**/*.lua",
    group = group,
    callback = function(args)
      if vim.endswith(args.file, "_spec.lua") then
        return
      end

      if args.file:match("nvim/init.lua") then
        return
      end

      reload.reload_module(args.file)
      vim.cmd.luafile(args.file)
      vim.schedule(function()
        print("reloaded:", args.file)
      end)
    end
  }
)

vim.api.nvim_create_autocmd("TextYankPost",
  {
    pattern = "*",
    group = group,
    callback = function(args)
      vim.highlight.on_yank { higroup = "IncSearch", timeout = 400 }
    end
  }
)
