local Range = require("modules.lib.range")
local Position = require("modules.lib.position")
local utils = require("utils")

local M = {}

M.marks = {}
M.args = {}
M.save_next_args = false

function M.print_registers()
  print(vim.inspect(vim.api.nvim_buf_get_mark(0, "<")))
  print(vim.inspect(vim.api.nvim_buf_get_mark(0, ">")))
end

function M.backup_registers()
  for _, mark in ipairs({ "<", ">" }) do
    local row, col = unpack(vim.api.nvim_buf_get_mark(0, mark))
    M.marks[mark] = { row = row, col = col }
  end
end

function M.restore_registers()
  for mark, data in pairs(M.marks) do
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
  end
end

function M.extract_cmd_from_args(args)
  return args.args
end

function M.maybe_backup_args(args)
  if not M.save_next_args then return end

  M.original_args = args
  M.save_next_args = false
end

function M.heal_arguments(args)
  args.line1 = M.original_args.line1
  args.line2 = M.original_args.line2

  return args
end

function M.get_execute_cmd(target_func)
  return function(args)
    M.maybe_backup_args(args)
    args = M.heal_arguments(args)

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

local group = vim.api.nvim_create_augroup("visual_command", {})

vim.api.nvim_create_autocmd("CmdLineEnter",
  {
    group = group,
    callback = function()
      M.save_next_args = true
    end,
  }
)

vim.api.nvim_create_autocmd("CmdLineLeave",
  {
    group = group,
    callback = function()
      M.save_next_args = false
      M.original_args = {}
    end,
  }
)

-- vim.cmd [[ Norm diw ]]

return {
  setup = setup
}
