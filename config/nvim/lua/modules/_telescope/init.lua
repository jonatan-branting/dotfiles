local telescope = require('telescope')
local actions = require('telescope.actions')

require("modules._telescope.overrides").setup()

-- local utils = require("modules._telescope.utils")

-- telescope.load_extension("frecency")
-- telescope.load_extension('lsp_handlers')
-- telescope.load_extension('lsp_handlers')

-- Quickly reload for development
local plenary = require'plenary'
local nnoremap = require'astronauta.keymap'.nnoremap
nnoremap { '<leader>?', function()
  plenary.reload.reload_module('telescope')
  plenary.reload.reload_module('telescope.overrides')
  vim.cmd("luafile ~/.config/nvim/lua/modules/_telescope/init.lua")

  require('telescope.builtin').find_files()
end }

-- local transform_mod = require('telescope.actions.mt').transform_mod
local _my_actions = {}

-- function _my_actions.open_qflist_conditionally(_)
--   if #vim.fn.getqflist() > 0 or true then
--     vim.cmd [[copen]]
--   end
-- end

-- require("telescope.actions").open_qflist_conditionally = transform_mod(_my_actions).open_qflist_conditionally

require('telescope').setup{
  defaults = {
    history_location = '~/.local/share/nvim/telescope_history',
    history_limit = 1000,
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
    mappings = {
      i = {
        -- ["<C-p>"] = actions.cycle_history_prev,
        -- ["<C-n>"] = actions.cycle_history_next,
        ["<esc>"] = actions.close,
        ["<tab>"] = actions.move_selection_next,
        ["<s-tab>"] = actions.move_selection_previous,
        ["<S-CR>"] = actions.smart_send_to_qflist + actions.open_qflist,
        -- ["<cr>"] = actions.select_default + actions.center,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<C-k>"] = actions.preview_scrolling_up,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    sorting_strategy = "descending",
    -- scroll_strategy = "cycle",
    layout_strategy = "current_horizontal_buffer",
    -- layout_strategy = "bottom_bar",
    initial_mode = "insert",
    -- preview_cutoff = 50, -- Preview should always show (unless previewer = false)
    -- width = 100,
    -- winblend = 8,
    borderchars = {
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {" ", " ", " ", " ", " ", " ", " ", " "},
      results = {" ", " ", " ", " ", " ", " ", " ", " "},
    },
    -- file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    file_ignore_patterns = {},
    -- generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- shorten_path = true,
    color_devicons = false,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('sessions')
