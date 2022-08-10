local buffers = require("buffers")

local M = {}
function M.range(a, b, step)
  if not b then
    b = a
    a = 1
  end
  step = step or 1
  local f =
    step > 0 and
    function(_, lastvalue)
      local nextvalue = lastvalue + step
      if nextvalue <= b then return nextvalue end
    end or
      step < 0 and
      function(_, lastvalue)
        local nextvalue = lastvalue + step
        if nextvalue >= b then return nextvalue end
      end or
    function(_, lastvalue) return lastvalue end
  return f, nil, a - step
end

-- Remove once https://github.com/neovim/neovim/pull/13896 lands
-- Get the region between two marks and the start and end positions for the region
--
--@param mark1 Name of mark starting the region
--@param mark2 Name of mark ending the region
--@param options Table containing the adjustment function, register type and selection mode
--@return region region between the two marks, as returned by |vim.region|
--@return start (row,col) tuple denoting the start of the region
--@return finish (row,col) tuple denoting the end of the region
function M.get_marked_region(mark1, mark2, options)
  local bufnr = 0
  local adjust = options.adjust or function(pos1, pos2)
    return pos1, pos2
  end
  local regtype = options.regtype or vim.fn.visualmode()
  local selection = options.selection or (vim.o.selection ~= 'exclusive')

  local pos1 = vim.fn.getpos(mark1)
  local pos2 = vim.fn.getpos(mark2)
  pos1, pos2 = adjust(pos1, pos2)

  local start = { pos1[2] - 1, pos1[3] - 1 + pos1[4] }
  local finish = { pos2[2] - 1, pos2[3] - 1 + pos2[4] }

  -- Return if start or finish are invalid
  if start[2] < 0 or finish[1] < start[1] then return end

  local region = vim.region(bufnr, start, finish, regtype, selection)
  return region, start, finish
end

-- Get the current visual selection as a string
--
--@return selection string containing the current visual selection
function M.get_visual_selection()
  local bufnr = 0
  local visual_modes = {
    v = true,
    V = true,
    -- [t'<C-v>'] = true, -- Visual block does not seem to be supported by vim.region
  }

  -- Return if not in visual mode
  if visual_modes[vim.api.nvim_get_mode().mode] == nil then return end

  local options = {}
  options.adjust = function(pos1, pos2)
    if vim.fn.visualmode() == "V" then
      pos1[3] = 1
      pos2[3] = 2^31 - 1
    end

    if pos1[2] > pos2[2] then
      pos2[3], pos1[3] = pos1[3], pos2[3]
      return pos2, pos1
    elseif pos1[2]==pos2[2] and pos1[3] > pos2[3] then
      return pos2, pos1
    else
      return pos1, pos2
    end
  end

  local region, start, finish = M.get_marked_region('v', '.', options)

  -- Compute the number of chars to get from the first line,
  -- because vim.region returns -1 as the ending col if the
  -- end of the line is included in the selection
  local lines = vim.api.nvim_buf_get_lines(bufnr, start[1], finish[1] + 1, false)
  local line1_end
  if region[start[1]][2] - region[start[1]][1] < 0 then
    line1_end = #lines[1] - region[start[1]][1]
  else
    line1_end = region[start[1]][2] - region[start[1]][1]
  end

  lines[1] = vim.fn.strpart(lines[1], region[start[1]][1], line1_end, true)
  if start[1] ~= finish[1] then
    lines[#lines] =
      vim.fn.strpart(
        lines[#lines],
        region[finish[1]][1],
        region[finish[1]][2] - region[finish[1]][1]
      )
  end
  return table.concat(lines)
end

function M.has_key(table, _key)
  for key, _ in pairs(table) do
    if key == _key then
      return true
    end
  end

  return false
end

function M.has_value(table, val)
  for _, value in ipairs(table) do
    if value == val then
      return true
    end
  end

  return false
end

function M.is_floating(win)
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

function M.floating_windows_exist()
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if M.is_floating(winid) then
      return true
    end
  end

  return false
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.imerge(a, b)
  for _,v in ipairs(b) do table.insert(a, v) end
  return a
end

function M.merge(a, b)
  for k,v in pairs(b) do a[k] = v end
  return a
end

-- copied from nvim-surround
M.get_selection = function(is_visual)
  -- Determine whether to use visual marks or operator marks
  local mark1, mark2
  if is_visual then
    mark1, mark2 = "<", ">"
  else
    mark1, mark2 = "[", "]"
    buffers.adjust_mark("[")
    buffers.adjust_mark("]")
  end

  -- Get the row and column of the first and last characters of the selection
  local first_position = buffers.get_mark(mark1)
  local last_position = buffers.get_mark(mark2)
  if not first_position or not last_position then
    return nil
  end

  local selection = {
    first_pos = first_position,
    last_pos = last_position,
  }
  return selection
end

function M.total_columns()
  return vim.api.nvim_get_options("columns")
end

function M.seq(a, b)
  local sequence = {}

  for i = a, b do
    table.insert(sequence, i)
  end

  return sequence
end

-- vim ranges are 1, 1 indexed
-- marks are 1, 0 indexed
function M.vim_range_from_mark(range)
  local start_row, start_col, end_row, end_col = unpack(range)

  return { start_row, start_col + 1, end_row, end_col + 1}
end

-- vim ranges are 1, 1 indexed
function M.vim_range_from_ts(range, bufnr)
  local bufnr = bufnr or 0
  return require("nvim-treesitter.ts_utils").get_vim_range(range, bufnr)
end

-- works on 1, 1 indexed ranges (vim ranges)
-- calls func with 1, 1 indexed ranges
function M.iter_buffer_range(buffer, range, func, opts)
  local defaults = {
    linewise = false,
  }
  local opts = M.merge(defaults, opts or {})

  local start_row, start_col, end_row, end_col = unpack(range)

  local lines = vim.api.nvim_buf_get_lines(buffer, start_row - 1, end_row, true)

  if end_col == -1 then
    end_col = #lines[#lines]
  end

  local function line_content(row, scol, ecol)
    if opts.linewise then return lines[row] end

    return string.sub(lines[row], scol, ecol)
  end

  if start_row == end_row then
    func(line_content(1, start_col, end_col), start_row, start_col, end_col)
  else
    -- first line
    func(line_content(1, start_col, end_col),
      start_row, start_col, -1)

    -- middle
    for i in M.range(2, #lines - 1) do
      func(line_content(i, 1, -1),
        start_row + i, 1, -1)
    end

    -- end
    func(line_content(#lines, 1, end_col),
      end_row, 1, end_col)
  end
end

-- 1, 1 indexed
-- TODO: use the builting vim.highlight.range instead...
function M.highlight_range(ns, range, opts)
  local opts = opts or {}
  local start_row, start_col, end_row, end_col = unpack(range)
  local hl_group = opts.hl_group or "Visual"

  vim.highlight.range(ns, 0, hl_group, {start_row, start_col}, {end_row, end_col},{})
end
return M
