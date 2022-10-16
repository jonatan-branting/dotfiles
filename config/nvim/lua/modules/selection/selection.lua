local Range = require("modules.lib.range")
local Selection = {}

function Selection:new(session, range)
  local start_row, start_col, end_row, end_col = unpack(range)

  range = Range:new({start_row, start_col}, {end_row, end_col})
  range:anchor(session.ns, session.bufnr)

  local selection = { session = session, range = range}
  setmetatable(selection, self)
  self.__index = self

  return selection
end

function Selection:get()
 return self.range:get()
end

function Selection:get_text()
  local str = ""

  F.iter_session_range(self.session.bufnr, self.range:get(), function(line)
    str = str .. line
  end, { linewise = false })

  return string.sub(str, 1, #str)
end

-- TODO move to Range
function Selection:contains_range(range)
  local _start_row, _start_col, _end_row, _end_col = unpack(range:get())
  local start_row, start_col, end_row, end_col = unpack(self.range:get())

  if start_row > _start_row or end_row < _end_row then
    return false
  end

  -- start
  if start_row == _start_row and start_col < _start_col then
    return false
  end

  -- end
  if end_row == _end_row and end_col < _end_col then
    return false
  end

  return true
end

-- TODO move out to range
function Selection:highlight()
  local start_row, start_col, end_row, end_col = unpack(self.range:get())

  -- this apparently takes a 0, 0 based index
  vim.highlight.range(self.session.bufnr, self.session.hi_ns, "Visual",
    {start_row - 1, start_col - 1}, {end_row - 1, end_col - 1}, { inclusive = true }
  )
end

return Selection
