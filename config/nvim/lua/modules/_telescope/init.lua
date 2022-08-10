local telescope = require('telescope')
local actions = require('telescope.actions')

local strategies = require("modules._telescope.layout_strategies")
local get_status = require("telescope.state").get_status

require'telescope.pickers.layout_strategies'.horizontal = strategies.horizontal
require'telescope.pickers.layout_strategies'.vertical = strategies.vertical
require'telescope.pickers.layout_strategies'.flex = strategies.flex
-- telescope.load_extension("frecency")

-- Quickly reload for development
require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  defaults = {
    history_location = '~/.local/share/nvim/telescope_history',
    history_limit = 1000,
    extensions = {
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<S-CR>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-k>"] = actions.preview_scrolling_up,
      },
    },
    file_ignore_patterns = { ".*%.DS_Store", ".*%.min.js", "%.git/.*", "%karabiner/.*json" },
    sorting_strategy = "descending",
    initial_mode = "insert",
    scroll_strategy = "limit",
    multi_icon = "> ",
    layout_strategy = "flex",
    color_devicons = false,
    selection_strategy = "reset",
    -- path_display = { truncate = 5 }
    path_display = function(opts, path)
      -- TODO truncate including text please...
      -- print("path", vim.inspect(opts))
      -- local status = get_status(vim.api.nvim_get_current_buf())
      -- local width = vim.api.nvim_win_get_width(status.results_win)
      -- print(path)
      -- print(width)
      return path
      -- return require("telescope.utils").path_smart(path)
    end,
    preview_title = " ",
    winblend = vim.opt.winblend._value, -- extract from global settings instead
    selection_caret = "  ",
    results_title = " ",
    debounce = 250,
    prompt_title = " ",
    preview = {
      treesitter = false,
    },
    layout_config = {
      horizontal = {
        prompt_position = "bottom",
        preview_width = 0.51,
        width = 0.95,
      },
      vertical = {
        prompt_position = "bottom",
        mirror = false,
        width = 0.9,
      },
      height = 0.9,
      -- dynamic_preview_title = true,
    },
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
    -- { "single", { "┌", "─", "┐", "│", "┘", "─", "└", "│" }, false },
    -- "z",
    -- prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
    -- results = { " " },
    -- -- results = { "a", "b", "c", "d", "e", "f", "g", "h" },
    -- preview = { " ", " ", " ", " ", " ", " ", " ", " "},
    ,
  },
  pickers = {
    find_files = {
      disable_devicons = true,
    },
    grep_string = {
      disable_devicons = true,
      debounce = 250,
      path_display = { "shorten" }
    },
    live_grep = {
      disable_devicons = true,
      debounce = 250,
      path_display = { "shorten" }
    }
  },
}

require('telescope').load_extension("fzf")
require("telescope").load_extension("git_worktree")
-- require('telescope').load_extension("dap")
-- require("telescope").load_extension("git_worktree")
-- require("telescope").load_extension("ui-select")
-- require('telescope').load_extension("possession")
require("telescope").load_extension("file_browser")
-- require("telescope").load_extension("lsp_handlers")
