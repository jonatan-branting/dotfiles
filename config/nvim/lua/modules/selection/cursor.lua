local Position = require("modules.lib.position")
local Selection = require("modules.selection.selection")

--- Represents a virtual cursor.
local Cursor = {}

function Cursor:new(session, position)
  if getmetatable(position) ~= Position then
    position = Position.new(self, unpack(position))
  end

  position:anchor(session.ns, session.bufnr)

  local selection = Selection.new(self, session, { position, position })

  -- TODO create selection matching `position` immediately.
  local cursor = { session = session, position = position, selection = selection}
  setmetatable(cursor, self)
  self.__index = cursor
end

--- Moves the virtual cursor to `position`, and uses `selector` to apply the
--- proper selection afterwards. An empty function will yield no selections.
---@param new_position Position
---@param selector function A function taking two arguments: a before position
---  and an after position
function Cursor:move(new_position, selector)
  local old_position = self.position
  new_position:anchor()
  old_position:remove_anchor()

  self.position = new_position

  selector(old_position, new_position)
end

--- Applies a highlight to the cursor in the buffer
function Cursor:highlight()
  self.selection:highlight()
end

--- Moves the cursor to the start of it's `selection`.
function Cursor:goto_start()
 
end

--- Moves the cursor to the end of it's `selection`.
function Cursor:goto_end()
end

--- Moves the real cursor the the position of this virtual cursor.
function Cursor:activate()
end

function Cursor:execute_interactive_operator(operator)
  -- This should be convenience? with the actual function placed elesewhere?
  -- operator.lua > execute_operator_on_cursor(operator, cursor)
  local start_row, start_col, end_row, end_col = unpack(self.selection:get())
  vim.api.nvim_buf_set_mark(0, "[", start_row, start_col - 1, {})
  vim.api.nvim_buf_set_mark(0, "]", end_row, end_col - 1, {})
  vim.api.nvim_win_set_cursor(0, unpack(self.position:get()))

  vim.api.nvim_feedkeys(operator, "n", false)
  vim.api.nvim_set_cursor(0, { start_row, start_col - 1}, {})
  vim.api.nvim_feedkeys("v", "n", false) -- TODO: take other modes into account here...
  vim.api.nvim_set_cursor(0, { end_row, end_col - 1}, {})
  -- vim.schedule(function())
end

function Cursor:execute_operator(operator)
  -- This should be convenience? with the actual function placed elesewhere?
  -- operator.lua > execute_operator_on_cursor(operator, cursor)
  local start_row, start_col, end_row, end_col = unpack(self.selection:get())
  vim.api.nvim_buf_set_mark(0, "[", start_row, start_col - 1, {})
  vim.api.nvim_buf_set_mark(0, "]", end_row, end_col - 1, {})
  vim.api.nvim_win_set_cursor(0, unpack(self.position:get()))

  vim.api.nvim_feedkeys(operator, "n", false)
  vim.api.nvim_set_cursor(0, { start_row, start_col - 1}, {})
  vim.api.nvim_feedkeys("v", "n", false) -- TODO: take other modes into account here...
  vim.api.nvim_set_cursor(0, { end_row, end_col - 1}, {})

  local row, col = unpack(vim.api.nvim_get_cursor(0))
  self:move({row, col + 1}, function() end) -- TODO use selector!
  -- vim.schedule(function())
end

-- TODO restore cursor?
function Cursor:execute_operator(operator)
  -- This should be convenience? with the actual function placed elesewhere?
  -- operator.lua > execute_operator_on_cursor(operator, cursor)
  local start_row, start_col, end_row, end_col = unpack(self.selection:get())
  vim.api.nvim_buf_set_mark(0, "[", start_row, start_col - 1, {})
  vim.api.nvim_buf_set_mark(0, "]", end_row, end_col - 1, {})
  vim.api.nvim_win_set_cursor(0, unpack(self.position:get()))

  vim.api.nvim_feedkeys(operator, "n", false)
  vim.api.nvim_set_cursor(0, { start_row, start_col - 1}, {})
  vim.api.nvim_feedkeys("v", "n", false) -- TODO: take other modes into account here...
  vim.api.nvim_set_cursor(0, { end_row, end_col - 1}, {})

  local row, col = unpack(vim.api.nvim_get_cursor(0))
  self:move({row, col + 1}, function() end) -- TODO use selector!
  -- vim.schedule(function())
end

function Cursor:select_range(range)
  self.selection:select_range(range, {})
end

return Cursor
