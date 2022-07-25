local utils = require("utils")
local M = {}
local Buffer = {}
local Cursor = {}

-- Buffer

function Buffer:new(bufnr)
  local buffer =  { cursors = {}, bufnr = bufnr, ns = vim.api.nvim_create_namespace(""), hi_ns = vim.api.nvim_create_namespace("") }

  setmetatable(buffer, self)
  self.__index = self

  return buffer
end

function Buffer:clear_highlights()
  vim.api.nvim_buf_clear_namespace(self.bufnr, self.hi_ns, 0, -1)
end

function Buffer:render_highlights()
  self:clear_highlights()

  for _, cursor in pairs(self.cursors) do
    -- TODO: move to Cursor
    local row, col = unpack(cursor:position())
    vim.api.nvim_buf_add_highlight(self.bufnr, self.hi_ns, "lCursor", row, col,  col + 1)
  end
end

function Buffer:clear_selection()
  self:clear_highlights()

  vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
  self.cursors = {}
end

function Buffer:place_cursor(row, col)
  local cursor = Cursor:new(self, row, col)
  self.cursors[cursor.id] = cursor
  self:render_highlights()
end

function Buffer:remove_cursor_by_id(id)
  local cursor = self.cursors[id]
  if not cursor then return false end

  vim.api.nvim_buf_del_extmark(self.bufnr, self.ns, cursor.id)
  self.cursors[id] = nil

  return true
end

function Buffer:cursor_at_location( row, col)
  for _, cursor in pairs(self.cursors) do
    local row_, col_ = unpack(cursor:position())
    if row_ == row - 1 and col_ == col - 1 then return cursor end
  end

  return false
end

function Buffer:generate_targets()
  local targets = {}

  for _, cursor in pairs(self.cursors) do
    local row, col = unpack(cursor:position())
    local target = { pos = { row + 1, col + 1 } }
    table.insert(targets, target)
  end

  return targets
end

-- Cursor

function Cursor:new(buffer, row, col)
  local id = vim.api.nvim_buf_set_extmark(
    buffer.bufnr, buffer.ns, row - 1, col - 1,
    {
      hl_group = "MatchParen",
      virt_text = {{"<", "MatchParen"}},
      virt_text_pos = "right_align"
    }
  )

  local cursor = { buffer = buffer, id = id } -- id == extmark
  setmetatable(cursor, self)
  self.__index = self

  return cursor
end

function Cursor:position()
  return vim.api.nvim_buf_get_extmark_by_id(self.buffer.bufnr, self.buffer.ns, self.id, {})
end

-- Userspace

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

function M.toggle_cursor(row, col)
  local buffer = get_current_buffer()

  local existing_cursor = buffer:cursor_at_location(row, col)
  if existing_cursor then
    buffer:remove_cursor(existing_cursor.id)
  else
    buffer:place_cursor(row, col)
  end

  buffer:render_highlights()
end

function M.place_cursor(row, col)
  local buffer = get_current_buffer()
  buffer:place_cursor(row, col)
end

function M.clear_highlights()
  get_current_buffer():clear_highlights()
end

function M.opfunc()
  -- ds
  M.operator = vim.v.operator
  require("modules.ex_normal_preview").setup("SM", true, buffer:generate_targets())
end

function M.norm_on_selection()
  local buffer = get_current_buffer()

  buffer:clear_highlights()

  require("modules.ex_normal_preview").setup("SM", true, buffer:generate_targets())
  vim.api.nvim_feedkeys(utils.t("<esc>:SM<space>"), "n", false)

  vim.schedule(function()
    buffer:clear_selection()
  end)
end

function M.setup()
  vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI", "TextChangedP"},
    {
      callback = function()
        local buffer = get_current_buffer()
        buffer:render_highlights()
      end
    }
  )
end

M.setup()

return M
