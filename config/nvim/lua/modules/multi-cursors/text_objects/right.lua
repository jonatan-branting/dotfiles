local Range = require("modules.lib.range")

return function(cursor)
  local row, col = unpack(cursor.pos:get())

  return Range:new({row, col}, {row, col})
end
