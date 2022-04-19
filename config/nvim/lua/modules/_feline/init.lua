local components = require('modules._feline.components')
local lsp_progress = require('modules._feline.lsp_progress_component')
local colors = require('modules._feline.colors')

local function lsp_progress_component(_active)
  return {
    provider = function() return lsp_progress.progress() end
  }
end

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
  mid = { active = {}, inactive = {}},
  right = {
    active = {},
    inactive = {}
  }
}

properties.force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  -- 'startify',
  'fugitive',
  'fugitiveblame',
  'fzf'
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
  fg = colors.fg_side,
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
    components.file_info_component,
    -- components.treesitter_location
  },
  side = 'left',
  hl = { active = active_inner_hl, inactive = inactive_inner_hl }
}


local right_edge = {
  components = {
    -- components.git_diff_total_edited_component,
    components.git_branch_component,
    components.spacing_component,
  },
  side = 'right',
  hl = {active = active_edge_hl, inactive = inactive_edge_hl}
}

local right_inner = {
  components = {
    -- components.diagnostic_errors_component,
    -- components.diagnostic_warnings_component,
    -- components.diagnostic_info_component,
    components.lsp_client_names_component,
    components.spacing_component,
    -- function() return { provider = '', left_sep = 'slant_left' } end,
    lsp_progress_component,
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

  component.hl_inner = component.hl

  component.hl = function()
    local current_hl = type(component.hl_inner) == "function" and component.hl_inner() or component.hl_inner or {}

    return {
      bg = current_hl.bg or hl.bg,
      fg = current_hl.fg or hl.fg,
      style = current_hl.style or hl.style
    }
  end

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

local c = {
  active = {},
  inactive = {}
}
table.insert(c.active, statusline_components.left.active)
table.insert(c.active, statusline_components.mid.active)
table.insert(c.active, statusline_components.right.active)

table.insert(c.inactive, statusline_components.left.inactive)
table.insert(c.inactive, statusline_components.mid.inactive)
table.insert(c.inactive, statusline_components.right.inactive)

require('feline').setup({
    default_bg = colors.bg_active,
    default_fg = colors.fg_active,
    vi_mode_colors = {
      INSERT = "#f7768e"
    },
    components = c,
    properties = properties,
})
