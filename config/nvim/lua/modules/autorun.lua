local M = {}

local function create_augroup()
  return vim.api.nvim_create_augroup("AutoRun", {})
end

M.group = create_augroup()
M.autocmds = {}


function M.setup_autorun(func)
  local autocmd = vim.api.nvim_create_autocmd("BufWritePost",
    -- TODO pattern = ""
    {
      group = M.group,
      callback = function(args)
        local cmd = func(args)
        vim.cmd(cmd)
        vim.schedule(function() print("Autoran: " .. cmd) end)
      end
    }
  )
  table.insert(M.autocmds, autocmd)
end

function M.current_lua_file()
  local file = vim.fn.expand("%:p")

  M.setup_autorun(function(args)
    return "luafile " .. file
  end)
end

function M.command(command)
  return function () return command end
end

function M.clear()
  vim.api.nvim_del_augroup_by_id(M.group)

  M.group = create_augroup()
end

return M
