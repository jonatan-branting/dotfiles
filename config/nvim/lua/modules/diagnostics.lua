local utils = require("utils")
-- local function code_action_listener()
--   local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
--   local params = vim.lsp.util.make_range_params()
--   params.context = context
--   vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
--     -- do something with result - e.g. check if empty and show some indication such as a sign
--   end)
-- end

local diagnostics_group = vim.api.nvim_create_augroup("diagnostics", { clear = true })
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  group = diagnostics_group,
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
})

-- vim.api.nvim_create_autocmd("CursorHold", {
--   group = "diagnostics",
--   callback = function()
--     if utils.floating_windows_exist() then return end

--     vim.diagnostic.open_float(nil, {
--       focusable = false,
--     })
--   end
-- })

local signs = { Error = "• ", Warn = "• ", Hint = "• ", Info = "• " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  update_in_insert = false,
  signs = {
    severity = { min = vim.diagnostic.severity.INFO, max = vim.diagnostic.severity.WARN },
    enabled = true,
    priority = 15
  },
  severity_sort = true,
  float = {
    border = "single",
    format = function(diagnostic)
      return string.format(
       "%s (%s) [%s]",
        diagnostic.message,
        diagnostic.source,
        diagnostic.code or (diagnostic.user_data and diagnostic.user_data.lsp.code) or {}
      )
    end,
  },
})
