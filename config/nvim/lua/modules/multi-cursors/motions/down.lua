return function(cursor)
  local row, col = unpack(cursor.pos:get())

  if row == vim.fn.line("$") then
    return
  end

  cursor:move({ row + 1, col })
end
