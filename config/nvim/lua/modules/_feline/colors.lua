local color_utils = require("modules.ui.utils")
local utils = require("utils")

local M = {}

M.colors = {
  bg = color_utils.get_highlight("Statusline").bg,
  fg = color_utils.get_highlight("Statusline").fg,

  red = color_utils.get_highlight("DiagnosticError").fg,
  green = color_utils.get_highlight("String").fg,
  blue = color_utils.get_highlight("Function").fg,
  gray = color_utils.get_highlight("NonText").fg,
  orange = color_utils.get_highlight("Constant").fg,
  purple = color_utils.get_highlight("Statement").fg,
  cyan = color_utils.get_highlight("Special").fg,

  diag_warn = color_utils.get_highlight("DiagnosticWarn").fg,
  diag_error = color_utils.get_highlight("DiagnosticError").fg,
  diag_hint = color_utils.get_highlight("DiagnosticHint").fg,
  diag_info = color_utils.get_highlight("DiagnosticInfo").fg,

  git_del = color_utils.get_highlight("DiffDelete").fg,
  git_add = color_utils.get_highlight("DiffAdd").fg,
  git_change = color_utils.get_highlight("DiffChange").fg,
}

local variations = {}

-- for k, v in pairs(M.colors) do
--   variations["bright_" .. k] = color_utils.brighten(v, 0.25)
--   variations["faded_" .. k] = color_utils.darken(v, 0.75)
--   variations["dark_" .. k] = color_utils.darken(v, 0.75)
-- end


M.colors = utils.merge(M.colors, variations)

M.fg_sides = color_utils.invert(M.colors.bg)
M.bg_sides = color_utils.invert(M.colors.fg)
M.bg_active = M.colors.bright_bg
M.bg_inactive = M.colors.bg
M.fg_active = M.colors.fg
M.fg_inactive = M.colors.dark_fg


return M
