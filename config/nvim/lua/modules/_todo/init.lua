local Path = require("plenary.path")
local M =  {}

function M.generate_template(filename)
  return string.format(
    [[
# %s
1.
    ]], filename)
end

M.options = {
  todo_dir = "~/git/todos",
  window_cmd = "botright split",
  template_func = M.generate_template,
  window_height = 15
}


function M.open_window_with_file(path)
  vim.cmd(string.format([[ %s %s ]], M.options.window_cmd, path))

  -- TODO this introduces a jumping behaviour, should be doable with a single command
  -- vim.api.nvim_command(string.format([[ resize %s ]], M.options.window_height))
end

local function maybe_create_file(path)
  path:touch({parents = true})

  local file_is_empty = #path:read() == 0

  if file_is_empty then
    path:write(M.options.template_func(M.current_todo_identifier()), "w")
  end
end

function M.open_branch_todo()
  local path = Path:new(
    Path:new(M.options.todo_dir):expand(),
    M.current_repository_branch_filename()
  )

  maybe_create_file(path)

  return M.open_window_with_file(path)
end

function M.current_repository_branch_filename()
  return string.format("%s_todo.md", M.current_todo_identifier())
end

function M.current_todo_identifier()
  local root_path = Path:new(vim.b.gitsigns_status_dict.root):_split()
  local root = root_path[#root_path]

  local branch = vim.b.gitsigns_status_dict.head

  return root .. "/" .. branch
end

function M.setup_commands()
  -- TODO
end

function M.setup()
  -- TODO
end

return M
