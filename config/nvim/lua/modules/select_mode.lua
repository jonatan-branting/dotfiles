local utils = require("utils")

local Buffer = {}
local Selection = {}

-- TODO bind to a current "instance" i.e. 
-- when you for example use it through occurrence modifier, that's a separate,
-- ephemeral instance, while using it manually is another, persistent instance

-- Helpers

-- TODO move out?
local function generate_targets(selections)
  local targets = {}

  for _, selection in pairs(selections) do
    local target = function()
      local start_row, start_col, end_row, end_col = unpack(selection:range())
      return { pos = { start_row, start_col, end_row, end_col } }
    end
    table.insert(targets, target)
  end

  return targets
end

-- Buffer

function Buffer:new(bufnr)
  local buffer = {
    selections = {},
    bufnr = bufnr,
    ns = vim.api.nvim_create_namespace(""),
    hi_ns = vim.api.nvim_create_namespace(""),
  }

  setmetatable(buffer, self)
  self.__index = self

  return buffer
end

function Buffer:clear_highlights()
  vim.api.nvim_buf_clear_namespace(self.bufnr, self.hi_ns, 0, -1)
end

-- doesn't work as expected
function Buffer:render_highlights()
  self:clear_highlights()
  self:for_each_selection(function(selection) selection:highlight() end)
end

function Buffer:for_each_selection(func)
  for _, selection in pairs(self.selections) do
    func(selection)
  end
end

function Buffer:clear_selection()
  self:clear_highlights()

  vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
  self.selections = {}
end

function Buffer:get_selections_containing_range(range)
  local selections_in_range = {}

  for _, selection in ipairs(self.selections) do
    if selection:contains_range(range) then
      table.insert(selections_in_range, selection)
    end
  end

  return selections_in_range
end

function Buffer:select_range(range, opts)
  local opts = opts or {}
  local start_row, start_col, end_row, end_col = unpack(range)
  -- TODO remove selections which this one contain
  local selection = Selection:new(self, start_row, start_col, end_row, end_col)

  if not opts.ephemeral then
    table.insert(self.selections, selection)
    self:render_highlights()
  end

  return selection
end

-- 
function Buffer:generate_selection_targets()
  return generate_targets(self.selections)
end

function Buffer:get_last_selection()
  return self.selections[#self.selections]
end

-- Selection

-- 1, 1 indexed
function Selection:new(buffer, start_row, start_col, end_row, end_col)
  local start = vim.api.nvim_buf_set_extmark(
    buffer.bufnr, buffer.ns, start_row - 1, start_col - 1, {})
  local end_ = vim.api.nvim_buf_set_extmark(
    buffer.bufnr, buffer.ns, end_row - 1, end_col - 1, {})

  assert(start ~= nil, "start is nil: " .. start_row .. ", " .. start_col )
  assert(end_ ~= nil, "end is nil: " .. end_row .. ", " .. end_col )
  ---- print(start, end_)

  local selection = { buffer = buffer, start = start, end_ = end_, id = start .. end_ }
  setmetatable(selection, self)
  self.__index = self

  return selection
end

function Selection:get_text()
  local str = ""

  F.iter_buffer_range(self.buffer.bufnr, self:range(), function(line)
    str = str .. line
  end, { linewise = false })

  return string.sub(str, 1, #str)
end

function Selection:range_start()
  return vim.api.nvim_buf_get_extmark_by_id(self.buffer.bufnr, self.buffer.ns, self.start, {})
end

function Selection:range_end_()
  return vim.api.nvim_buf_get_extmark_by_id(self.buffer.bufnr, self.buffer.ns, self.end_, {})
end

function Selection:range()
  local start_row, start_col = unpack(self:range_start())
  local end_row, end_col = unpack(self:range_end_())

  -- return a 1, 1 based range
  return { start_row + 1, start_col + 1, end_row + 1, end_col + 1 }
end

function Selection:contains_range(range)
  local _start_row, _start_col, _end_row, _end_col = unpack(range)
  local start_row, start_col, end_row, end_col = unpack(self:range())

  if start_row > _start_row or end_row < _end_row then
    return false
  end

  -- start
  if start_row == _start_row and start_col < _start_col then
    return false
  end

  -- end
  if end_row == _end_row and end_col < _end_col then
    return false
  end

  return true
end

function Selection:highlight()
  local start_row, start_col, end_row, end_col = unpack(self:range())

  -- this apparently takes a 0, 0 based index
  vim.highlight.range(self.buffer.bufnr, self.buffer.hi_ns, "Visual",
    {start_row - 1, start_col - 1}, {end_row - 1, end_col - 1}, { inclusive = true }
  )
end

-- Userspace

local M = {}

M.buffers = {}

setmetatable(M.buffers, {
  __index = function(table, bufnr)
    local buffer = Buffer:new(bufnr)
    table[bufnr] = buffer

    return buffer
  end
})

local function get_current_buffer()
  local bufnr = vim.api.nvim_get_current_buf()

  return M.buffers[bufnr]
end

M.get_current_buffer = get_current_buffer

function M.clear_highlights()
  get_current_buffer():clear_highlights()
end

function M.generate_targets(selections)
  return generate_targets(selections)
end

function M.clear_selection()
  get_current_buffer():clear_selection()
end

-- expect 1, 1 based ranges
function M.select_range(buffer, range, opts)
  local buffer = get_current_buffer()
  local opts = opts or {}

  -- TODO extract a bit better
  -- ignore this if ephemeral?
  -- namespaces of some sort seem like a better idea...
  local containing_selections = buffer:get_selections_containing_range(range)

  if #containing_selections == 0 or opts.ephemeral then -- refactor this, this is just bad
    return buffer:select_range(range)
  end
end

function M.opfunc()
  -- siw
  local buffer = get_current_buffer()
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(buffer.bufnr, "["))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(buffer.bufnr, "]"))

  -- marks are 1, 0 based, convert to vim-range
  local range = utils.vim_range_from_mark({start_row, start_col, end_row, end_col})

  -- 1, 1 indexed
  get_current_buffer():select_range(range, {})
end

-- TODO make this a lot simpler but expose callback and customization functionality.
-- Keep `select-mode` clean
function M.motion(opts)
  print(">enter motion")

  local buffer = get_current_buffer()
  local defaults = {
    preselect = true,
    reverse = false,
    selections = buffer.selections,
    operator = vim.v.operator,
  }

  local opts = utils.merge(defaults, opts or {})

  vim.v.operator = nil

  -- perhaps there is a better way to do this, but this
  -- allows us to wait for the next ex_normal_preview command
  vim.api.nvim_feedkeys(utils.t("<esc>"), "n", false)

  vim.schedule(function()
    require("modules.ex_normal_preview").setup("SM", {
      ephemeral = true,
      targets = function() return generate_targets(opts.selections) end,
      preselect = opts.preselect,
      reverse = opts.reverse,
    })
    -- TODO make feedkeys part of exnormal preview and auto tear down on cancel
    -- as well
    vim.api.nvim_feedkeys(utils.t("<esc>:SM<space>" .. opts.operator), "n", false)
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI", "TextChangedP"},
    {
      callback = function()
        local success, err_msg = pcall(function()
          get_current_buffer():render_highlights()
        end)

        if not success then
          print("error highlighting selections:", err_msg)
        end
      end
    }
  )
end

M.setup()

return M
