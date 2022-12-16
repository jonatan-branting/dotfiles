local Position = require("modules.lib.position")
local utils = require("utils")

--- Returns all selected lines as Positions
--
local function targets_from_rows(rows)
  local targets = {}
  for _, row in ipairs(rows) do
    -- ignore empty lines
    local content = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

    -- strip whitespace
    content = content:gsub("^%s*(.-)%s*$", "%1")

    if #content > 0 then
      local col = vim.fn.indent(row)
      local target = { pos = { row, col + 1 } }

      table.insert(targets, target)
    end
  end
  return targets
end

return function(args)
  return targets_from_rows(utils.seq(args.line1, args.line2))
end
