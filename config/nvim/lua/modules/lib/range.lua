local Position = require("modules.lib.position")
local Range = {}

local function get_normalized_range(pos1, pos2)
  if pos2 > pos1 then return { pos1, pos2 } end

  return { pos2, pos1 }
end

-- allows passing in either a { {number, number }, {number, number} } range, or
-- a { Position, Position } range
function Range:new(pos1, pos2)
  print(vim.inspect(pos1), vim.inspect(pos2))
  if getmetatable(pos1) ~= Position then
    local row, col = unpack(pos1)
    pos1 = Position:new(row, col)
  end

  if getmetatable(pos2) ~= Position then
    local row, col = unpack(pos2)
    pos2 = Position:new(row, col)
  end
  print(vim.inspect(pos1), vim.inspect(pos2))

  local from, to = unpack(get_normalized_range(pos1, pos2))

  local position = { from = from, to = to}
  setmetatable(position, self)
  self.__index = self

  return position
end

function Range:_eq(other)
  return self.from == other.from and self.to == other.to
end

function Range:anchor(ns, bufnr)
  self.from:anchor(ns, bufnr)
  self.to:anchor(ns, bufnr)
end

function Range:update(pos1, pos2)
  if getmetatable(pos1) ~= Position then
    local row, col = unpack(pos1)
    pos1 = Position:new(row, col)
  end

  if getmetatable(pos2) ~= Position then
    local row, col = unpack(pos2)
    pos2 = Position:new(row, col)
  end

  self.from:remove_anchor()
  self.to:remove_anchor()

  self.from, self.to = get_normalized_range(pos1, pos2)
end

function Range:get()
  local start_row, start_col = unpack(self.from:get())
  local end_row, end_col = unpack(self.to:get())

  return { start_row, start_col, end_row, end_col }
end

return Range
