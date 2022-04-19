local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
  ensure_installed = "maintained",
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-big'
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
    enable = false,
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
  textobjects = {
    move = {
      enable = false,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      }
    }
  }
}
