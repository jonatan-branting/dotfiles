local Terminal = require("modules.term.terminal")

local Handler = {}
function Handler:new()
  local handler = {
    terminals = {},
  }

  setmetatable(handler, self)
  self.__index = self

  return handler
end

function Handler:get_terminal(idx)
  idx = idx or #self.terminals

  if not self.terminals[idx] then
    self.terminals[idx] = Terminal:new(idx)
  end

  return self.terminals[idx]
end

return Handler
