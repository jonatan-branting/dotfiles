local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local nnoremap = require('astronauta.keymap').nnoremap
local plenary = require('plenary')
local path = require('plenary.path')
local fn = vim.fn
local o = vim.o
local bo = vim.bo
local b = vim.b

nnoremap { '<leader>a', function()
  vim.cmd("w")
  require('plenary.reload').reload_module('feline')
  vim.cmd("luafile ~/.config/nvim/lua/plugins/feline.lua")
end }

local colors = {
  bg0_h = '#1d2021',
  bg0_s = '#32302f',
  bg0 = '#282828',
  bg1 = '#3c3836',
  bg2 = '#504945',
  bg3 = '#665c54',
  bg4 = '#7c6f64',
  fg0 = '#fbf1c7',
  fg1 = '#ebdbb2',
  fg2 = '#d5c4a1',
  fg3 = '#bdae93',
  fg4 = '#a89984',
  fg5 = '#999999',
  bright_red     = '#fb4934',
  bright_green   = '#b8bb26',
  bright_yellow  = '#fabd2f',
  bright_blue    = '#83a598',
  bright_purple  = '#d3869b',
  bright_aqua    = '#8ec07c',
  bright_orange  = '#fe8019',
  neutral_red    = '#cc241d',
  neutral_green  = '#98971a',
  neutral_yellow = '#d79921',
  neutral_blue   = '#458588',
  neutral_purple = '#b16286',
  neutral_aqua   = '#689d6a',
  neutral_orange = '#d65d0e',
  faded_red      = '#9d0006',
  faded_green    = '#79740e',
  faded_yellow   = '#b57614',
  faded_blue     = '#076678',
  faded_purple   = '#8f3f71',
  faded_aqua     = '#427b58',
  faded_orange   = '#af3a03',
}

local bg_sides = colors.fg2

local properties = {
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
  }
}

local components = {
  left = {
    active = {},
    inactive = {}
  },
  right = {
    active = {},
    inactive = {}
  }
}

properties.force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame',
  'help'
}

properties.force_inactive.buftypes = {
  'terminal'
}

function column_component(active)
  return {
    provider = function()
      local col = vim.fn.col('.')

      local total_width = math.max(vim.fn.strlen(vim.fn.line('$')) + 1, vim.wo.numberwidth)

      if active then
        local padding_width = total_width - vim.fn.strlen(vim.fn.col('.')) + 1
        local padding = string.rep(" ", padding_width)
        return padding .. tostring(col) .. " "
      else
        return " " .. string.rep("-", total_width) .. " "
      end
    end,
    hl = {
      fg = colors.bg1,
      bg = bg_sides
    }
  }
end

function file_info_component(active)
  inactive_hl = {
    fg = colors.fg2,
    bg = colors.bg2,
  }
  active_hl = {
    fg = colors.fg0,
    bg = colors.bg4,
  }

  return {
    provider = function()
      local filename = fn.expand('%')
      local extension = fn.expand('%:e')
      local relative_filename = path:new(filename):make_relative()

      local file_string
      if string.len(relative_filename) > 34 then
        file_string = path:new(relative_filename):shorten()
      elseif string.len(relative_filename) == 0 then
        file_string = vim.bo.filetype
      else
        file_string = relative_filename
      end

      if active then
        return  " ›› "  .. file_string  .. " ‹‹ "
      else
        return " ‹‹ " .. file_string .. " ›› "
      end
    end,
    hl = active and active_hl or inactive_hl,
  }
end

local file_size_component = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  right_sep = {
    ' ',
    {
      str = 'slant_left_2_thin',
      hl = {
        fg = 'fg',
        bg = 'bg'
      }
    },
    ' '
  }
}

local diagnostic_errors_component = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist('Error') end,
  hl = { fg = 'red' }
}

local diagnostic_warnings_component = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist('Warning') end,
  hl = { fg = 'yellow' }
}

local diagnostic_hints_component = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist('Hint') end,
  hl = { fg = 'cyan' }
}

local diagnostic_info_component = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist('Information') end,
  hl = { fg = 'skyblue' }
}

local git_branch_component = {
  provider = function()
    if not b.gitsigns_status_dict then return ' <untracked>' end

    local head = b.gitsigns_status_dict.head

    if #head > 0 then
      return '  ' .. head
    else
      return ''
    end
  end,
  hl = {
    fg = colors.bg1,
    bg = bg_sides,
    style = 'bold'
  },
}

local git_diff_added_component = {
  provider = 'git_diff_added',
  hl = {
    fg = colors.faded_green,
    bg = bg_sides,
  }
}

local git_diff_changed_component = {
  provider = 'git_diff_changed',
  hl = {
    fg = colors.faded_yellow,
    bg = bg_sides,
  }
}


local git_diff_removed_component = {
  provider = 'git_diff_removed',
  hl = {
    fg = colors.faded_red,
    bg = bg_sides,
  }
}

local file_diff_component = function()
  local provider
  if not b.gitsigns_status_dict or not bo.modified then
    provider = ''
  else
    provider = '  '
  end

  return {
    provider = provider,
    hl = { fg = colors.faded_yellow, bg = bg_sides }
  }
end

local spacing_component  = {
  provider = ' ',
  hl = { bg = bg_sides }
}

local line_percentage_component = {
  provider = 'line_percentage',
  hl = {
    style = 'bold',
    bg = bg_sides,
  },
  left_sep = '  ',
  right_sep = ' '
}

components.left.active = {
  column_component(true),
  file_info_component(true),
  diagnostic_errors_component,
  diagnostic_warnings_component,
  diagnostic_info_component,
  diagnostic_hints_component
}

components.left.inactive = {
  column_component(false),
  file_info_component(false),
  diagnostic_errors_component,
  diagnostic_warnings_component,
  diagnostic_info_component,
  diagnostic_hints_component
}

components.right.active = {
  git_branch_component,
  git_diff_added_component,
  git_diff_changed_component,
  git_diff_removed_component,
  file_diff_component(),
  spacing_component
}

components.right.inactive = {
  git_branch_component,
  git_diff_added_component,
  git_diff_changed_component,
  git_diff_removed_component,
  file_diff_component(),
  spacing_component
}


require('feline').setup({
    default_bg = colors.bg2,
    default_fg = colors.fg0,
    components = components,
    properties = properties,
})
