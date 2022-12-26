return function(cursor)
  local row, col = unpack(cursor.pos:get())

  if vim.fn.col("$") - 1 == col then
    return
  end

  cursor:move({ row, col + 1 })
end
