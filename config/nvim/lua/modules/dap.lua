local ok, dap = pcall(require, "dap")
local async = require("neotest.async")
local path = require("plenary.path")

if not ok then
  return
end

require("nvim-dap-virtual-text").setup {

  enabled = true,                        -- enable this plugin (the default)
  enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = true,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,               -- show stop reason when stopped for exceptions
  commented = true,                     -- prefix virtual text with comment string
  only_first_definition = false,          -- only show virtual text at first definition (if there are multiple)
  all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
  filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
  -- experimental features:
  virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
  all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

dap.set_log_level('TRACE');
dap.defaults.fallback.terminal_win_cmd = "80vsplit new"
dap.defaults.fallback.auto_continue_if_many_stopped = false

vim.fn.sign_define('DapBreakpoint', {text='*'})
vim.fn.sign_define('DapStopped', {text='>'})

dap.adapters.ruby = function(callback, config)
  local handle
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local pid_or_err
  local port = config.port or 38698
  local server = config.server or "127.0.0.1"

  local opts = {
    stdio = {nil, stdout, stderr},
    args = {"--open", "--port", port, "-c", "--", config.program, config.args},
    detached = false,
  }

  handle, pid_or_err = vim.loop.spawn("rdbg", opts, function(code)
    handle:close()
    stdout:close()

    if code ~= 0 then
      print('rdbg exited with code', code)
    end
  end)

  assert(handle, 'Error running rdbg: ' .. tostring(pid_or_err))

  local on_read = function(err, chunk)
    assert(not err, err)
    if not chunk then
      return
    end


    vim.schedule(function()
      require('dap.repl').append(chunk)

      for _, c in pairs(require("dap").listeners.after["event_output"]) do
        c(nil, chunk)
      end
    end)
  end

  stdout:read_start(on_read)
  stderr:read_start(on_read)

  vim.defer_fn(function()
    callback({
      type = "server",
      host = server,
      port = port,
    })
  end, 500)
end

dap.configurations.ruby = {
  {
    type = "ruby",
    name = "RSpec (current file)",
    request = "launch",
    program = "${workspaceFolder}/bin/rspec",
    localfs = true,
    args = {
      "${file}",
    },
  }
}

local hydra = require("modules.hydra").dap
dap.listeners.after.event_output["dapui_config"] = function(a, b)
end
dap.listeners.after.event_initialized["dapui_config"] = function()
  hydra:activate()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  hydra.layer:exit()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  hydra.layer:exit()
end
