-- Copied from folk/tokyonight

local hsluv = require("modules.ui.hsluv")
local utils = {}
utils.fg = "#c0caf5"
utils.bg = "#1f2335"

local function hex_to_rgb(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local r, g, b = string.match(hex_str, pat)
  return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

function utils.rgb_to_hex(rgb)
  if not rgb then return nil end

  return string.format("#%06x", rgb)
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function utils.blend(fg, bg, alpha)
  bg = hex_to_rgb(bg)
  fg = hex_to_rgb(fg)

  local blendChannel = function(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function utils.darken(hex, amount, bg)
  return utils.blend(hex, bg or utils.bg, math.abs(amount))
end
function utils.lighten(hex, amount, fg)
  return utils.blend(hex, fg or utils.fg, math.abs(amount))
end

function utils.brighten(color, percentage)
  local hsl = hsluv.hex_to_hsluv(color)
  local larpSpace = 100 - hsl[3]
  if percentage < 0 then
    larpSpace = hsl[3]
  end
  hsl[3] = hsl[3] + larpSpace * percentage
  return hsluv.hsluv_to_hex(hsl)
end

function utils.invert(color)
  if color ~= "NONE" then
    local hsl = hsluv.hex_to_hsluv(color)
    hsl[3] = 100 - hsl[3]
    if hsl[3] < 40 then
      hsl[3] = hsl[3] + (100 - hsl[3]) * 0.5 -- day brightness originally
    end
    return hsluv.hsluv_to_hex(hsl)
  end
  return color
end

function utils.get_color(color)
  if vim.o.background == "dark" then
    return color
  end
  if not utils.colorCache[color] then
    utils.colorCache[color] = utils.invertColor(color)
  end
  return utils.colorCache[color]
end

function utils.get_highlight(name)
  local success, result = pcall(function()
    local hl = vim.api.nvim_get_hl_by_name(name, true)

    hl.fg = utils.rgb_to_hex(hl.foreground)
    hl.bg = utils.rgb_to_hex(hl.background)
    hl.sp = utils.rgb_to_hex(hl.special)

    hl.foreground = nil
    hl.backgroung = nil
    hl.special = nil

    return hl
  end)

  if not success then print("error", result) end

  return result
end

return utils
