local Position = {}

-- TODO: these "primitives"  are useful elsewhere... ( in select mode, while
-- generating selects..., this is before they belong to a session...)
--
-- Extract!
-- Position is just row, col with helper methods
-- a Row is just 2 positions with helper methods

function Position:new(row, col)
  local position = { extmark = nil, _row = row, _col = col}
  setmetatable(position, self)
  self.__index = self

  return position
end

function Position:__lt(other)
  -- No matter what happens, if a position starts earlier than another, this
  -- will always be the case
  if self._row == other._row then
    return self._col < other._col
  end

  return self._row < other._row
end

function Position:__le(other)
  -- No matter what happens, if a position starts earlier than another, this
  -- will always be the case
  if self._row == other._row then
    return self._col <= other._col
  end

  return self._row <= other._row
end

function Position:anchor(ns, bufnr)
  if self.extmark then return  self.extmark end

  self.extmark = {
    id = vim.api.nvim_buf_set_extmark(bufnr, ns, self._row - 1, self._col - 1, {}),
    bufnr = bufnr,
    ns = ns
  }

  return self.extmark.id
end

function Position:is_anchored(bufnr)
  if not self.extmark then return false end

  -- TODO this does not take bufnr into account
  return true
end

function Position:get()
  if not self.extmark then
    return { self._row, self._col }
  end

  local row, col = unpack(vim.api.nvim_buf_get_extmark_by_id(
    self.extmark.bufnr, self.extmark.ns, self.extmark.id, {}))
  return { row + 1, col + 1 }
end

function Position:remove_anchor()
  vim.api.nvim_buf_del_extmark(self.extmark.bufnr, self.extmark.ns, self.extmark.id)
  self.extmark = nil
end

function Position:update(position)
  self._row, self._col = unpack(position)

  if not self.extmark then return end

  local bufnr = self.extmark.bufnr
  local ns = self.extmark.ns
  self:remove_anchor()
  self:anchor(bufnr, ns)
end

return Position
