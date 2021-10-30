local ok, dap = pcall(require, "dap")

if not ok then
  return
end

dap.set_log_level('TRACE');
dap.defaults.fallback_terminal_win_cmd = "50vsplit new"

dap.adapters.ruby = {
  type = 'executable',
  command = 'bundle',
  args = {'exec', 'readapt', 'stdio'},
}

-- dap.configurations.ruby = {{
--     type = 'ruby',
--     request = 'launch',
--     name = 'Rails',
--     program = 'bundle',
--     programArgs = {'exec', 'rails', 's'},
--     useBundler = true,
-- }}

dap.configurations.ruby = {{
    type = 'ruby',
    request = 'launch',
    name = 'RSpec (Active File)',
    program = 'bundle',
    programArgs = {
      'exec',
      'rspec',
      '${file}'
    },
    useBundler = true,
}}

vim.fn.sign_define('DapBreakpoint', {text='B', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='X', texthl='', linehl='', numhl=''})

local function debug_rspec(file)
  print("Running Rspec via nvim-dap for " .. file)
  dap.run {
    type = 'ruby',
    request = 'launch',
    name = 'RSpec (Active File)',
    program = 'rspec',
    programArgs = {
      "${workspaceFolder}/" ..file
    },
    useBundler = false,
  }
end

_G.debug_rspec = debug_rspec

-- require("dapui").setup({
--   icons = {
--     expanded = "▾",
--     collapsed = "▸"
--   },
--   mappings = {
--     -- Use a table to apply multiple mappings
--     expand = {"<CR>", "<2-LeftMouse>"},
--     open = "o",
--     remove = "d",
--     edit = "e",
--   },
--   sidebar = {
--     open_on_start = true,
--     elements = {
--       -- You can change the order of elements in the sidebar
--       "scopes",
--       "breakpoints",
--       "stacks",
--       "watches"
--     },
--     width = 40,
--     position = "left" -- Can be "left" or "right"
--   },
--   tray = {
--     open_on_start = true,
--     elements = {
--       "repl"
--     },
--     height = 10,
--     position = "bottom" -- Can be "bottom" or "top"
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil   -- Floats will be treated as percentage of your screen.
--   }
-- })

return { debug_rspec = debug_rspec }

