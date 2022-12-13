local M = {}


--- Used to select the character at the cursor
---@param _opts 
---@return ... range how are these supposed to be written?
function M.select(_opts)
  return function(_, after)
    local after_row, after_col = unpack(after)
    return { after_row, after_col + 1, after_row, after_col + 1 }
  end
end

return M
