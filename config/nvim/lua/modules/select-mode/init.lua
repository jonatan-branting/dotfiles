local utils = require("utils")

local select = require("modules.selection")
local Position = require("modules.lib.position")
local Range = require("modules.lib.range")

local M = {}

local function keymap_from_key(bufnr, mode, key)
  local transformed_key = utils.t(key)

  for _, keymap in ipairs(vim.api.nvim_buf_get_keymap(bufnr, mode)) do
    if keymap.lhs == transformed_key then
      return keymap
    end
  end

  for _, keymap in ipairs(vim.api.nvim_get_keymap(mode)) do
    if keymap.lhs == transformed_key then
      return keymap
    end
  end
end

local function keymap_from_key_(mode, key)
  local transformed_key = utils.t(key)

  for _, keymap in ipairs(vim.api.nvim_get_keymap(mode)) do
    if keymap.lhs == transformed_key then
      return keymap
    end
  end
end


function M.setup_select_move_(bufnr, key, select_func, opts)
  local defaults = {
    beginning_inclusive = false,
    end_inclusive = true,
  }
  local opts = utils.merge(defaults, opts or {})

  local keymap = keymap_from_key(bufnr, "n", key)
  if keymap and keymap.desc == "select_mode_remap" then
    return
  end

  local action = (keymap and (keymap.callback or keymap.rhs)) or key

  vim.keymap.set({"o", "n"}, "<plug>(custom)" .. key, action, { buffer = bufnr, desc="select_mode_remap", expr = keymap and keymap.expr })

  local f = function()
    local before = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_feedkeys(utils.t(vim.v.count1 .. "<plug>(custom)" .. key), "n", false)
    vim.schedule(function()
      local after = vim.api.nvim_win_get_cursor(0)
      select.clear_selection()

      local range = select_func(before, after)

      if not range then return end
      select.select_range(range, {})
    end)
  end

  vim.keymap.set("n", key, f, { buffer = bufnr, desc = "select_mode_remap" })
end

function M.setup_select_move__(key, select_func, opts)
  local defaults = {
    beginning_inclusive = false,
    end_inclusive = true,
  }
  local opts = utils.merge(defaults, opts or {})

  local keymap = keymap_from_key_("n", key)
  if keymap and keymap.desc == "select_mode_remap" then
    return
  end

  local action = (keymap and (keymap.callback or keymap.rhs)) or key

  vim.keymap.set({"o", "n"}, "<plug>(custom)" .. key, action, { desc="select_mode_remap", expr = keymap and keymap.expr })

  local f = function()
    local before = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_feedkeys(utils.t(vim.v.count1 .. "<plug>(custom)" .. key), "n", false)
    vim.schedule(function()
      local after = vim.api.nvim_win_get_cursor(0)
      select.clear_selection()

      local range = select_func(before, after)

      if not range then return end
      select.select_range(range, {})
    end)
  end

  vim.keymap.set("n", key, f, { desc = "select_mode_remap" })
end

function M.setup_select_move(key, select_func, opts)
  M.setup_select_move__(key, select_func, opts)
  -- vim.api.nvim_create_autocmd("BufEnter", {
  --   callback = function(data)
  --     -- allow ignoring buffers
  --     -- print(vim.inspect(data))
  --     -- print(data.buf, key, select_func, opts)
  --     vim.schedule(function()
  --         M.setup_select_move_(data.buf, key, select_func, opts)
  --       end
  --     )
  --   end
  -- })
end

-- what is the current selection? is there such a thing?
function M.execute_operator(operator, opts)
  local session = select.get_current_session()
  local defaults = {
    preselect = true,
    reverse = false,
    selections = session.selections,
    interactive = false,
  }

  local opts = utils.merge(defaults, opts or {})

  require("modules.ex_normal_preview").setup("SM", {
    ephemeral = true,
    targets = function() return select.generate_targets(opts.selections) end,
    preselect = opts.preselect,
    reverse = operator,
  })
  -- for target in select.generate_targets()
  if opts.interactive and #session.selections > 1 then
    vim.api.nvim_feedkeys(utils.t("<esc>:SM<space>" .. operator), "n", false)
  end
  vim.cmd("SM " .. operator)
end

-- TODO this has to autoselect stuff on insertleave textchanged, etc. based on
-- the last selection mode, i.e. if we word selected we are now extending the
-- word, if we char selected we keep char selecting. basically just reapply the
-- same selct func
function M.setup_autocmds()
end

return M
