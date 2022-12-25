local function delete_single_line(range)
  local start_row, start_col, end_row, end_col = unpack(range:get())

  local line = vim.api.nvim_buf_get_lines(0, start_row - 1, start_row, true)[1]
  local new_line = line:sub(1, start_col - 1) .. line:sub(end_col + 1, -1)

  local removed_lines = {line:sub(start_col, end_col)}

  vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, true, {new_line})

  return removed_lines
end

local function delete_multiple_lines(range)
  local start_row, start_col, end_row, end_col = unpack(range:get())

  local start_line = vim.api.nvim_buf_get_lines(0, start_row - 1, start_row, true)[1]
  local new_start_line = start_line:sub(1, start_col - 1)

  local end_line = vim.api.nvim_buf_get_lines(0, end_row - 1, end_row, true)[1]
  local new_end_line = end_line:sub(end_col + 1, - 1)

  local removed_lines = {}
  table.insert(removed_lines, start_line:sub(start_col, -1))
  for i = 1, end_row - start_row - 1 do
    table.insert(removed_lines, vim.api.nvim_buf_get_lines(0, i, i + 1, true)[1])
  end
  table.insert(removed_lines, end_line:sub(1, end_col))

  vim.api.nvim_buf_set_lines(0, start_row - 1, end_row, true, {new_start_line .. new_end_line})

  return removed_lines
end

return function(range)
  local start_row, _, end_row, _ = unpack(range:get())

  local removed_lines = {}
  if start_row == end_row then
    removed_lines = delete_single_line(range)
  else
    removed_lines = delete_multiple_lines(range)
  end

  return removed_lines
end
