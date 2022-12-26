return function(cursor)
  local row, col = unpack(cursor.pos:get())

  if col == 1 then
    return
  end

  cursor:move({ row, col - 1 })
end
