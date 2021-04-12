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
local finders = require('telescope.finders')

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
  1, resolve.resolve_height(math.min(4, math.floor(lines / 10)))(self, columns, lines)
  )

  min_preview_height = 20
  min_results_height = 20
  results.height = math.floor((lines)/ 2)
  prompt.height = 1

  preview.height = window_height - results.height - prompt.height - 2 - height_padding * 2


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

  results.title = false

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

local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local utils = require('telescope.utils')
local conf = require('telescope.config').values

sorters.grep_highlighter_only = function(opts)
  opts = opts or {}

  return sorters.Sorter:new {
    scoring_function = function() return 0 end,

    highlighter = function(_, prompt, display)
      return {}
    end,
  }
end

require('telescope.builtin').live_grep_raw = function(opts)
  opts.vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  opts.entry_maker = opts.entry_maker or make_entry.gen_from_vimgrep(opts)
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd)

  local tbl_clone = function(original)
    local copy = {}
    for key, value in pairs(original) do
      copy[key] = value
    end
    return copy
  end

  local cmd_generator = function(prompt)
    if not prompt or prompt == "" then
      return nil
    end

    local query = prompt
    local args = tbl_clone(opts.vimgrep_arguments)
    local single_quoted = prompt:match("'(.*)'")
    local double_quoted = prompt:match('"(.*)"')
    local paths = {}

    if single_quoted then
      query = single_quoted
    elseif double_quoted then
      query = double_quoted
    end

    if single_quoted or double_quoted then
      local before_args = prompt:match("(.-)['\"]")
      local after_args = prompt:match(".*['\"](.*)")
      local all_args = before_args .. ' ' .. after_args
      for arg in all_args:gmatch("%S+") do
        if arg:match('^-') then
          table.insert(args, arg)
        else
          -- Show graceful grep error
          -- Path cannot come before query
        end
      end
      for path in after_args:gmatch("%S+") do
        if not path:match('^-') then
          table.insert(paths, path)
        end
      end
    end

    return vim.tbl_flatten { args, '--', query, paths }
  end

  pickers.new(opts, {
    prompt_title = 'Live Grep Raw',
    finder = finders.new_job(cmd_generator, opts.entry_maker, opts.max_results, opts.cwd),
    previewer = conf.grep_previewer(opts),
    sorter = sorters.grep_highlighter_only(opts),
  }):find()
end


local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
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
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_strategy = "current_horizontal_buffer",
    results_title = false,
    preview_title = "Preview",
    preview_cutoff = 50, -- Preview should always show (unless previewer = false)
    width = 100,
    winblend = 8,
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {"━", "│", " ", "│", "┍", "┑", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      preview = { "━", "│", "─", "│", "┍", "┑", "┘", "└"},
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
