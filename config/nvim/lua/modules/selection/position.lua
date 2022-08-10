local Position = {}

-- TODO: these "primitives"  are useful elsewhere... ( in select mode, while
-- generating selects..., this is before they belong to a session...)
--
-- Extract!
-- Position is just row, col with helper methods
-- a Row is just 2 positions with helper methods

function Position:new(session, row, col)
  local extmark = vim.api.nvim_buf_set_extmark(
    session.bufnr, session.ns, row - 1, col - 1, {})

  local position = { extmark = extmark, session = session, _row = row, _col = col}
  setmetatable(position, self)
  self.__index = self

  return position
end

function Position:_lt(other)
  -- No matter what happens, if a position starts earlier than another, this
  -- will always be the case
  if self._row == other._row then
    return self.col < other.col
  end

  return self._row < other._row
end

function Position:_le(other)
  -- No matter what happens, if a position starts earlier than another, this
  -- will always be the case
  if self._row == other._row then
    return self.col <= other.col
  end

  return self._row <= other._row
end

function Position:get()
  local row, col = unpack(vim.api.nvim_buf_get_extmark_by_id(
    self.session.bufnr, self.session.ns, self._pos, {}))
  return { row + 1, col + 1 }
end

return Position
