local lsp_config = require('lspconfig')
require("lspkind").init()
require("treesitter-unit")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = nil }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, silent = true })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, silent = true })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, silent = true })

  if client.server_capabilities.signatureHelpProvider then
    require("modules._lsp.signature").setup(client)
  end

  require("better-n").register_keys(bufnr)
end

local servers = {
  "cssls",
  "solargraph",
  "html",
  "vuels",
}

require("mason-lspconfig").setup({
  ensure_installed = servers,
  -- automatic_installation = true,
})

for _, server in ipairs(servers) do
  lsp_config[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


require('rust-tools').setup({
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
})

lsp_config.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    config = {
      vetur = {
        ignoreProjectWarning = true
      }
    }
  }
}

lsp_config.sumneko_lua.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      completion = {
        callSnippet = "Disable"
      }
    }
  }
})
