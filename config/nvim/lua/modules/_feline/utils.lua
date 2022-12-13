local M = {}

local utils = require("tokyonight.util")

local function to_hex(rgb)
  if not rgb then return nil end
  return string.format("#%06x", rgb)
end

function M.get_highlight(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)

  hl.fg = to_hex(hl.foreground)
  hl.bg = to_hex(hl.background)
  hl.sp = to_hex(hl.special)
  hl.foreground = nil
  hl.backgroung = nil
  hl.special = nil
  return hl
end


return M
