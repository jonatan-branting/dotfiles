local lsp_config = require('lspconfig')
require("lspkind").init()
require("treesitter-unit")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { border = nil }
)

local capabilities = require("cmp_nvim_lsp").update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap("n", "<space>af", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  if client.server_capabilities.signatureHelpProvider then
    require("modules._lsp.signature").setup(client)
  end
  -- if client.supports_method('textDocument/codeAction') then
  --   require('modules._lsp.lightbulb').setup()
  -- end
  require("better-n").register_keys(bufnr)
end

local servers = {
  "cssls",
  "solargraph",
  "html",
  "vuels",
  "bashls",
}

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

local lua_config = require("lua-dev").setup({
  lspconfig = {
    cmd = {"lua-language-server"},
    on_attach = on_attach,
    capabilities = capabilities,
  },
  library = {
    vimruntime = true,
    types = true,
    plugins = true,
  },
  runtime_path = false,
})

lsp_config.sumneko_lua.setup(lua_config)
