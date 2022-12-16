local Range = require("modules.lib.range")
local Position = require("modules.lib.position")
local utils = require("utils")

local M = {}

M.marks = {}

function M.print_registers()
  print(vim.inspect(vim.api.nvim_buf_get_mark(0, "<")))
  print(vim.inspect(vim.api.nvim_buf_get_mark(0, ">")))
end

function M.backup_registers()
  for _, mark in ipairs({ "<", ">" }) do

    -- TODO: position
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, mark))
    -- print(row, col)
    M.marks[mark] = { row = row, col = col }
  end
end

function M.restore_registers()
  for mark, data in pairs(M.marks) do
    -- print("setting", mark, "as", data.row, ",", data.col)
    vim.api.nvim_buf_set_mark(
      0, mark, data.row, data.col, {}
    )
  end
end

function M.execute_cmd_on_targets(cmd, targets)
  M.backup_registers()

  for _,target in ipairs(targets) do
    local start_row, start_col = unpack(target.pos)
    vim.fn.cursor(start_row, start_col)
    vim.cmd("normal " .. cmd)
    M.restore_registers()
    M.print_registers()
  end
end

function M.extract_cmd_from_args(args)
  return args.args
end

function M.get_execute_cmd(target_func)
  return function(args)
    local cmd = M.extract_cmd_from_args(args)

    M.execute_cmd_on_targets(
      cmd, target_func(args)
    )
  end
end

function M.get_preview_cmd(target_func)
  return function(args)
    M.get_execute_cmd(target_func)(args)

    return 1
  end
end

function M.setup_visual_cmd(name, target_func)
  vim.api.nvim_create_user_command(
    name,
    M.get_execute_cmd(target_func),
    {
      preview = M.get_preview_cmd(target_func),
      nargs = 1,
      range = true,
    }
  )
end

local line_selector = require("modules.visual_command.selectors.line_selector")

M.setup_visual_cmd("Norm", line_selector)

-- vim.cmd [[ Norm diw ]]

return {
  setup = setup
}
