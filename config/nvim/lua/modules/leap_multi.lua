local api = vim.api
-- Note: The functions used here will be upstreamed eventually.
local ts_utils = require('nvim-treesitter.ts_utils')

local function get_nodes()
  local wininfo = vim.fn.getwininfo(api.nvim_get_current_win())[1]
  -- Get current TS node.
  local cur_node = ts_utils.get_node_at_cursor(0)
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

local function jump(target)
  local startline, startcol, _, _ = target.node:range()    -- (0,0)
  api.nvim_win_set_cursor(0, { startline + 1, startcol })  -- (1,0)
end

local function execute_on_targets(ns, targets, args, preview)
  -- Jump to each and execute the command sequence.
  local color_ns = vim.api.nvim_create_namespace("LeapMultiColorNs")
  vim.api.nvim_buf_clear_namespace(0, color_ns, 0, -1)

  for _, target in ipairs(targets) do
    local start_row, start_col = unpack(vim.api.nvim_buf_get_extmark_by_id(0, ns, target.extmark_id, {}))
    vim.fn.cursor(start_row, start_col)
    vim.cmd("normal " .. args)

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    if preview then
      vim.api.nvim_buf_add_highlight(0, color_ns, "Cursor", row - 1, col, col + 1 )
    end
  end
end

local function leap_multi(targets)
  local ns = vim.api.nvim_create_namespace("")
  -- Set an extmark as an anchor for each target, so that we can execute
  -- commands that modify the positions of the others (insert/change/delete).
  for _, target in ipairs(targets) do

    local line, col, _, _ = target.node:range()
    local id = vim.api.nvim_buf_set_extmark(0, ns, line + 1, col + 1, {})
    target.extmark_id = id
  end

  vim.api.nvim_buf_create_user_command(0, "Normal",
    function(opts, _, _)
      execute_on_targets(ns, targets, opts.args, false)
      vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

      vim.schedule(function ()
        vim.api.nvim_buf_del_user_command(0, "Normal")
      end)
    end,
    {
      nargs = 1,
      preview = function (opts, _, _)
        execute_on_targets(ns, targets, opts.args, true)

        return 1
      end
    }
  )
  vim.api.nvim_feedkeys(require("utils").t("<esc>:Normal<space>"), "n", false)
end

local function setup()
end

return {
  setup = setup,
  leap_multi = leap_multi,
  get_nodes = get_nodes
}
