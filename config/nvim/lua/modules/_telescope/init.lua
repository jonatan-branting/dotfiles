local telescope = require('telescope')
local actions = require('telescope.actions')

require("modules._telescope.overrides").setup()
telescope.load_extension("frecency")

-- Quickly reload for development
require('telescope').setup{
  defaults = {
    history_location = '~/.local/share/nvim/telescope_history',
    history_limit = 1000,
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        },
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<tab>"] = actions.move_selection_next,
        ["<s-tab>"] = actions.move_selection_previous,
        ["<S-CR>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-k>"] = actions.preview_scrolling_up,
      },
    },
    sorting_strategy = "descending",
    initial_mode = "insert",
    borderchars = {
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
      results = {" ", " ", " ", " ", " ", " ", " ", " "},
    },
    file_ignore_patterns = {},
    color_devicons = false,
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('dap')
require("telescope").load_extension("git_worktree")
require("telescope").load_extension("ui-select")
require('telescope').load_extension('possession')
