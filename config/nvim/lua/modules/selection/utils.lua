local M = {}

function M.generate_targets(selections)
  local targets = {}

  for _, selection in pairs(selections) do
    local target = function()
      local start_row, start_col, end_row, end_col = unpack(selection:range())
      return { pos = { start_row, start_col, end_row, end_col } }
    end
    table.insert(targets, target)
  end

  return targets
end

return M
