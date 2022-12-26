local Position = require("modules.lib.position")
local Cursor = {}

function Cursor:new(session, pos)
  if getmetatable(pos) ~= Position then
    pos = Position:new(unpack(pos))
  end

  pos:anchor(
    session.ns,
    session.bufnr,
    Cursor.extmark_highlight_opts()
  )

  local cursor = {
    pos = pos,
    active = false,
    session = session,
    clipboard = "",
    autocmd_group = vim.api.nvim_create_augroup("TestGroup", {})
  }

  setmetatable(cursor, self)
  self.__index = self

  cursor:setup_autocmds()

  return cursor
end

function Cursor.extmark_highlight_opts()
  return {
    virt_text = { { " ", "Cursor" } },
    virt_text_pos = "overlay",
    hl_mode = "replace",
  }
end

function Cursor:setup_autocmds()
  vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"},
    {
      group = self.autocmd_group,
      callback = function(args)
        if not self.active then return end

        local cursor_row, cursor_column = unpack(vim.api.nvim_win_get_cursor(0))
        self.pos:update({ cursor_row, cursor_column + 1})
      end
    }
  )
end

function Cursor:deactive()
  self.active = false
end

function Cursor:activate()
  self.active = true
end

function Cursor:sync()
  local row, col = unpack(self.pos:get())
  vim.api.nvim_win_set_cursor(0, { row, col - 1 })
end

function Cursor:move(pos)
  self.pos:update(pos)

  if self.active then
    self:sync()
  end
end

function Cursor:as_active(func)
  local real_cursor_pos = vim.api.nvim_win_get_cursor(0)
  self:sync()

  func(self)

  vim.api.nvim_win_set_cursor(0, real_cursor_pos)
end

return Cursor
