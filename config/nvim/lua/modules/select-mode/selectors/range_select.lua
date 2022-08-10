local utils = require("utils")
local Range = require("modules.lib.range")

local M = {}

--- A very simply selector which just returns the selected range. Useful for
--- movements such as `f`, `t` and such.
function M.select(opts)
  local defaults = {
    linewise = false
  }
  local opts = utils.merge(defaults, opts or {})

  return function(before, after)
    local range = Range:new(before, after)
    print("range", vim.inspect(range))
    local from = range.from:get()
    local to = range.to:get()

    print("range_select", vim.inspect(from), vim.inspect(to))
    if opts.linewise then
      return { from[1], 1, to[1], 1 }
    end

    return { from[1], from[2] + 1, to[1], to[2] + 1 }
  end
end

return M
