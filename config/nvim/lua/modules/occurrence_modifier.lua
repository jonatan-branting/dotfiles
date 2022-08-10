local select_mode = require("modules.select_mode")
local utils = require("utils")
local M = {}
-- TODO smarter selection of <cword>, make it a pattern instead and make sure
-- it's not surrounded by other characters?

function M.dummy_operatorfunc()
end

--save operatorfunc
local function find_occurrences(line, cword, start_idx, end_idx)
  local line = line
  local start_idx = start_idx or 1

  if end_idx and end_idx ~= 0 then
    line = string.sub(line, 1, end_idx)
  end

  local occurrences = {}

  while true do
    local idx = occurrences[#occurrences] and occurrences[#occurrences].end_ or start_idx
    local start, end_ = string.find(line, cword, idx, true)

    if start ~= nil then
      table.insert(occurrences, {start = start, end_ = end_})
    else
      goto end_
    end
  end

  ::end_::
  return occurrences
end

function M.motion()
  -- print("enter motion")
  -- save all operator information
  M.operator = vim.v.operator
  M.cword = vim.fn.expand("<cword>")
  M.old_opfunc = vim.go.operatorfunc
  print("opfunc:", vim.go.operatorfunc)

  vim.v.operator = vim.v.operator -- TODO might be something other than `o`
  -- TODO: backup and restore cursor here

  -- cancel current operator
  vim.go.operatorfunc = "v:lua.require'modules.occurrence_modifier'.dummy_operatorfunc"
  vim.api.nvim_feedkeys(utils.t("<esc>"), "o", false)

  vim.schedule(function()
    vim.go.operatorfunc = "v:lua.require'modules.occurrence_modifier'.opfunc"
    vim.api.nvim_feedkeys(utils.t("g@"), "n", false)
  end)
end

function M.opfunc()
  print(">enter opfunc")
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "["))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, "]"))
  print(start_row, start_col, end_row, end_col)

  local occurrences = {}

  -- find all occurrences
  -- marks are 1, 0 indexed
  local range = utils.vim_range_from_mark({start_row, start_col, end_row, end_col})
  F.iter_buffer_range(0, range, function(line, row, scol, ecol)
    print(row, scol, ecol, "=>", line)
    local line_occurrences = find_occurrences(line, M.cword, scol, ecol)
    for _, occurrence in ipairs(line_occurrences) do
      table.insert(occurrences, { row = row, start = occurrence.start, end_ = occurrence.end_})
    end
  end, { linewise = true })

  -- then add selections to the occurrences
  local selections = {}
  for _, occurrence in ipairs(occurrences) do
    local selection = select_mode.select_range(
      occurrence.row, occurrence.start, occurrence.row, occurrence.end_, {ephemeral = true})

    if selection then table.insert(selections, selection) end
  end

  -- finally run the "motion"
  vim.go.operatorfunc = M.old_opfunc or vim.go.operatorfunc
  select_mode.motion({operator = M.operator, selections = selections})
end

return M
