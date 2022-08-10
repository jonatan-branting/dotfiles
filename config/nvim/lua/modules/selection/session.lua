local selection_utils = require("modules.selection.utils")
local Cursor = require("modules.selection.cursor")

local Session = {}

-- Session

function Session:new(bufnr)
  local session = {
    cursors = {},
    bufnr = bufnr,
    ns = vim.api.nvim_create_namespace(""),
    hi_ns = vim.api.nvim_create_namespace(""),
  }

  setmetatable(session, self)
  self.__index = self

  return session
end

function Session:clear_highlights()
  vim.api.nvim_buf_clear_namespace(self.bufnr, self.hi_ns, 0, -1)
end

-- doesn't work as expected
function Session:render_highlights()
  self:clear_highlights()
  self:for_each_cursor(function(cursor) cursor:highlight() end)
end

function Session:for_each_cursor(func)
  for _, cursor in pairs(self.cursors) do
    func(cursor)
  end
end

function Session:clear_cursors()
  self:clear_highlights()

  vim.api.nvim_buf_clear_namespace(self.bufnr, self.ns, 0, -1)
  self.cursors = {}
end

function Session:add_cursor(position, opts)
  local opts = opts or {}

  local cursor = Cursor:new(self, position)
  table.insert(self.cursors, cursor)

  return cursor
end

-- function Session:get_selections_containing_range(range)
--   local selections_in_range = {}

--   for _, selection in ipairs(self.selections) do
--     if selection:contains_range(range) then
--       table.insert(selections_in_range, selection)
--     end
--   end

--   return selections_in_range
-- end

-- function Session:select_range(range, _opts)
--   local opts = opts or {}

--   -- TODO remove selections which this one contain
--   print(vim.inspect(range))
--   local selection = Selection:new(self, range)

--   if not opts.ephemeral then
--     table.insert(self.selections, selection)
--     self:render_highlights()
--   end


--   return selection
-- end

-- 
-- function Session:generate_selection_targets()
--   return selection_utils.generate_targets(self.selections)
-- end

-- function Session:get_last_selection()
--   return self.selections[#self.selections]
-- end

return Session
