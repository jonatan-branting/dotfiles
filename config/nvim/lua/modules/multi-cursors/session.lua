local Cursor = require("modules.multi-cursors.cursor")
local Session = {}

function Session:new()
  local session = {
    ns = vim.api.nvim_create_namespace("multi-cursors"),
    bufnr = 0,
    cursors = {},
  }

  setmetatable(session, self)
  self.__index = self

  return session
end

function Session:add_cursor(pos)
  local cursor = Cursor:new(self, pos)
  table.insert(self.cursors, cursor)

  cursor:activate()
end

function Session:execute_operator(operator)
  for _, cursor in ipairs(self.cursors) do
    local range = _G.text_object(cursor)
    local result = operator(range)

    cursor.clipboard = result or cursor.clipboard
  end
end

return Session
