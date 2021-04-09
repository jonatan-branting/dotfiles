local actions = require('telescope.actions')
local telescope = require('telescope')

local layout = function(picker, columns, lines)
  return {
    preview = self.previewer and preview.width > 0 and preview,
    results = results,
    prompt = prompt
  }
end

local resolve = require("telescope.config.resolve")

local function get_initial_window_options(picker)
  local popup_border = resolve.win_option(picker.window.border)
  local popup_borderchars = resolve.win_option(picker.window.borderchars)

  local preview = {
    title = picker.preview_title,
    border = popup_border.preview,
    borderchars = popup_borderchars.preview,
    enter = false,
    highlight = false
  }

  local results = {
    title = picker.results_title,
    border = popup_border.results,
    borderchars = popup_borderchars.results,
    enter = false,
  }

  local prompt = {
    title = picker.prompt_title,
    border = popup_border.prompt,
    borderchars = popup_borderchars.prompt,
    enter = true
  }

  return {
    preview = preview,
    results = results,
    prompt = prompt,
  }
end

require'telescope.pickers.layout_strategies'.current_horizontal_buffer = function(self, columns, lines)
  local initial_options = get_initial_window_options(self)

  local window_width = math.min(columns, 120)
  local window_height = lines

  local preview = initial_options.preview
  local results = initial_options.results
  local prompt = initial_options.prompt

  -- Width
  local width_padding = resolve.resolve_width(10)(self, columns, lines)

  local width = window_width - width_padding * 2
  if not self.previewer then
    preview.width = 0
  else
    preview.width = width
  end
  results.width = width
  prompt.width = width

  -- Height
  local height_padding = math.max(
  1, resolve.resolve_height(4)(self, columns, lines)
  )

  results.height = 20
  prompt.height = 1

  -- The last 2 * 2 is for the extra borders
  if self.previewer then
    preview.height = window_height - results.height - prompt.height - 2 * 2 - height_padding * 2
  else
    results.height = window_height - prompt.height - 2 - height_padding * 2
  end


  local line = 0
  if self.previewer then
    preview.line = height_padding + line
    prompt.line = preview.line + preview.height + 2
    results.line = prompt.line + prompt.height + 1
  else
    results.line = height_padding + line
    prompt.line = results.line + results.height + 1
  end

  col = math.ceil((columns / 2) - (width / 2) - 1)
  preview.col, results.col, prompt.col = col, col, col

  return {
    preview = preview.width > 0 and preview,
    results = results,
    prompt = prompt,
  }
end

local plenary = require 'plenary'
local nnoremap = require'astronauta.keymap'.nnoremap

nnoremap { '<leader>c', function()
  plenary.reload.reload_module('telescope')
  vim.cmd("luafile ~/.config/nvim/lua/plugins/telescope.lua")

  require('telescope.builtin').find_files()
end }


require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
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
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_strategy = "current_horizontal_buffer",
    results_title = false,
    preview_title = "Preview",
    preview_cutoff = 1, -- Preview should always show (unless previewer = false)
    width = 100,
    winblend = 3,
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {"─", "│", " ", "│", "├", "┤", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
      preview = { "─", "│", " ", "│", "╭", "╮", "│", "│"},
    },

    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_cat.new`
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_vimgrep.new`
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new, -- For buffer previewer use `require'telescope.previewers'.vim_buffer_qflist.new`

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}