local nnoremap = require('astronauta.keymap').nnoremap
local components = require('plugins._feline.components')
local colors = require('plugins._feline.colors')

-- Reload changes easily while editing plugin settings!
nnoremap { '<leader>a', function()
  vim.cmd("w")
  require('plenary.reload').reload_module('feline')
  vim.cmd("luafile ~/.config/nvim/lua/plugins/_feline/init.lua")
end }

local properties = {
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {}
  }
}

local statusline_components = {
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
  -- 'help'
}

properties.force_inactive.buftypes = {
  'terminal'
}


local active_inner_hl = {
  fg = colors.fg_active,
  bg = colors.bg_active
}

local inactive_inner_hl = {
  fg = colors.fg_inactive,
  bg = colors.bg_inactive
}

local active_edge_hl = {
  fg = colors.bg1,
  bg = colors.bg_sides
}

local inactive_edge_hl = active_edge_hl

local left_edge = {
  components = {
    components.column_component,
  },
  side = 'left',
  hl = { active = active_edge_hl, inactive = inactive_edge_hl }
}

local left_inner = {
  components = {
    components.file_info_component
  },
  side = 'left',
  hl = { active = active_inner_hl, inactive = inactive_inner_hl }
}


local right_edge = {
  components = {
    components.git_diff_total_edited_component,
    components.git_branch_component,
    components.spacing_component,
  },
  side = 'right',
  hl = {active = active_edge_hl, inactive = inactive_edge_hl}
}

local right_inner = {
  components = {
    components.diagnostic_errors_component,
    components.diagnostic_warnings_component,
    components.diagnostic_info_component,
    components.lsp_client_names_component,
    components.file_diff_component,
    components.spacing_component
  },
  side = 'right',
  hl = {active = active_inner_hl, inactive = inactive_inner_hl}
}

local sections = {left_edge, left_inner, right_inner, right_edge}

local function separator_with_highlight(sep, hl)
  if type(sep) == "string" then
    return { str = sep, hl = hl }
  elseif type(sep) == "table" then
    local new_hl = sep.hl or {}
    new_hl.bg = sep.hl.bg or hl.bg
    new_hl.fg = sep.hl.fg or hl.fg
    return new_hl
  end
end

local generate_component = function(component_func, is_active, hl)
  local component = component_func(is_active)
  component.hl = component.hl or {}
  component.hl.bg = component.hl and component.hl.bg or hl.bg
  component.hl.fg = component.hl and component.hl.fg or hl.fg

  component.left_sep = separator_with_highlight(component.left_sep, hl)
  component.right_sep = separator_with_highlight(component.right_sep, hl)

  return component
end

for _, section in ipairs(sections) do
  local _components, hl, side = section.components, section.hl, section.side

  for _, component in ipairs(_components) do
    statusline_components[side].active[#statusline_components[side].active + 1] =
      generate_component(component, true, hl.active)

    statusline_components[side].inactive[#statusline_components[side].inactive + 1] =
      generate_component(component, false, hl.inactive)
  end
end

require('feline').setup({
    default_bg = colors.bg_active,
    default_fg = colors.fg_active,
    components = statusline_components,
    properties = properties,
})
