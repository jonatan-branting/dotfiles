local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  -- ensure_installed = "all",
  sync_install = false,
  auto_intsall = true,
  nodeobject = {
    enable = true
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [']'] = 'textsubjects-container-outer',
      ['['] = 'textsubjects-container-inner',
    }
  },
  -- context_commentstring = {
  --   enable = true
  -- },
  autopairs = {
    enable = true
  },
  endwise = {
    enable = true,
  },
  indent = {
    enable = false
  },
  yati = {
    enable = true
  },
  highlight = {
    enable = true,
    -- additional_vim_regex_highlighting = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-n>",
      node_incremental = "<c-n>",
      scope_incremental = "<c-s>",
      node_decremental = "<c-p>"
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold"},
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 't',
      toggle_hl_groups = 'i',
      toggle_injected_languages = '0',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  -- will be handled by mini.ai instead,
  -- we're only interested in the queries
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.outer",
        ["]b"] = "@block.outer",
        -- ["]n"] = "@node",
        [")"]  = "@node",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.outer",
        ["[b"] = "@block.outer",
        -- ["pn"] = "@node", -- TODO inner/outer
        ["("] =  "@node",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<c-l>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<c-h>"] = "@parameter.inner",
      }
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- would be nice with fallbacks here... a lot of keys are required!
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        -- ["ab"] = "@block.outer",
        -- ["ib"] = "@block.inner",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
        ["ao"] = "@node", -- TODO inner/outer
        ["io"] = "@node", -- TODO inner/outer
      }
    }
  }
}
