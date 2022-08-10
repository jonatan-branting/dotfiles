local api = vim.api
local utils = require("utils")
-- Note: The functions used here will be upstreamed eventually.
local ts_utils = require('nvim-treesitter.ts_utils')
local ts_extras = require('treesitter_extras')

local function get_nodes()
  local win = api.nvim_get_current_win()
  local wininfo = vim.fn.getwininfo(win)[1]
  -- Get current TS node.
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))
  -- local col = #vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
  local cur_node = ts_extras.get_node_at_position(0, true, row - 1, col)
  -- TODO get node at position instead
  if not cur_node then return end
  -- Get parent nodes recursively.
  local nodes = { cur_node }
  local parent = cur_node:parent()
  while parent do
    table.insert(nodes, parent)
    parent = parent:parent()
  end
  -- Create Leap targets from TS nodes.
  local targets = {}
  for _, node in ipairs(nodes) do
    local startline, startcol, _, _ = node:range()  -- (0,0)
    if startline + 1 >= wininfo.topline then
      local target = { node = node, pos = { startline + 1, startcol + 1 } }
      table.insert(targets, target)
    end
  end
  if #targets >= 1 then return targets end
end

local function select_range(target)
  ts_utils.update_selection(0, target.node, "charwise")

  local state = require("leap").state
  state.args.did_jump = true
  -- vim.schedule(function()
  --   vim.api.nvim_feedkeys(state.args.operator, "n", false)
  -- end)
end

local function jump(target)
  local startline, startcol, _, _ = target.node:range()          -- (0,0)
  api.nvim_win_set_cursor(0, { startline + 1, startcol })  -- (1,0)

  require("leap").state.args.did_jump = {
    print = 123
  }
end

local function leap()
  local targets = get_nodes()
  local action = api.nvim_get_mode().mode == 'n' and jump or select_range
  require('leap').leap { targets = targets, action = action, backward = true }
end

return { leap = leap, targets = get_nodes, action = select_range }
