function k(key, mode)
  mode = mode or "n"
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, false)
end


k("<esc>", "n")

for _, win in ipairs(vim.api.nvim_list_wins()) do local config = vim.api.nvim_win_get_config(win); if config.relative ~= "" then vim.api.nvim_win_close(win, false); print('Closing window', win) end end

r = require("plenary.reload")
r.reload_module("modules.select_mode")
local select = require("modules.select_mode")

select.toggle_cursor(0, 10, 10)


-- local file = "/Users/jonatanbranting/.nvim/plugged/neotest-rspec/spec/sum.rb"
-- vim.api.nvim_exec("edit " ..  file, false)

-- vim.wait(500)
-- k("v")

-- vim.wait(1500)
-- vim.schedule(function ()
--   require"leap".leap {
--     target_windows = {vim.fn.win_getid()},
--     multiselect = true,
--     action = mappings.leap_paranormal2,
--     targets = mappings.get_targets(vim.fn.win_getid())
--   }
-- end)
-- vim.wait(250)
-- k("m")
-- vim.wait(250)
-- k("h")
-- vim.wait(250)
-- k("<cr>")
-- vim.wait(250)
-- k("ciw")
-- vim.wait(250)
-- k("test")

--
-- function() require("plenary").reload_module("modules.leap-multi"); require("modules.leap-multi")

-- local file = "/Users/jonatanbranting/.nvim/plugged/neotest-rspec/spec/sum.rb"
-- vim.api.nvim_exec("edit " ..  file, false)

-- vim.wait(100)

-- vim.api.nvim_exec("7", true)

-- local lsp_config = require('lspconfig')

r.reload_module("modules._lsp.signature")
-- r.reload_module("modules.diagnostic")
-- vim.diagnostic.config({})

-- local capabilities = require("cmp_nvim_lsp").update_capabilities(
--   vim.lsp.protocol.make_client_capabilities()
-- )

-- local on_attach = function(client, bufnr)
--   if client.server_capabilities.signatureHelpProvider then
--     require("modules._lsp.signature").setup(client)
--   end
-- end

-- for _, server in ipairs({"solargraph"}) do
--   lsp_config[server].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

-- k("<esc>", "n")

-- local file = "/Users/jonatanbranting/.nvim/plugged/neotest-rspec/spec/sum.rb"
-- vim.api.nvim_exec("edit " ..  file, false)

-- vim.api.nvim_exec("7", true)
-- vim.api.nvim_exec("normal otest(", true)

-- vim.defer_fn(function()
--   vim.api.nvim_input("a1")
-- end, 1000)
-- vim.defer_fn(function()
--   vim.api.nvim_input(",")
-- end, 1500)
-- vim.defer_fn(function()
--   vim.api.nvim_input("<space>")
-- end, 2000)

-- vim.defer_fn(function()
--   vim.api.nvim_input("213")
-- end, 3000)

-- vim.defer_fn(function()
--   vim.api.nvim_input(",")
-- end, 4000)

-- vim.defer_fn(function()
--   vim.api.nvim_input("<space>")
-- end, 4500)

-- vim.defer_fn(function()
--   vim.api.nvim_exec("w", true)
-- end, 5000)
