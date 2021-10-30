local lsp_config = require('lspconfig')
local lsp_status = require('lsp-status')
-- require("nvim-ale-diagnostic")
require("trouble").setup()
require("lspkind").init()
require("fzf_lsp").setup()
require("treesitter-unit")
-- require("lsp_signature").on_attach()

-- Allow ALE to handle diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- vim.lsp.handlers["textDocumentinitialize"] = vim.lsp.with(
--   function(message) print("INITINIT", message) end, {}
-- )

-- Enable snippet support
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = lsp_status.capabilities
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
local on_attach = function(_client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- require("lsp_signature").on_attach({
  --     bind = true,
  --     doc_lines = 2,
  --     hint_enable = false,
  --     hint_Scheme = "String",
  --     hi_parameter = "Search",
  --     fix_pos = true,
  --     handler_opts = {
  --       border = "shadow"
  --     },
  --     extra_trigger_chars = { "{", ","}
  --   })

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>af", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local servers = {
  "cssls",
  "solargraph",
  "vimls",
  -- "pyls_ms",
  "html",
  "denols",
  "dockerls",
  "bashls",
  "jsonls",
}

for _, server in ipairs(servers) do
  lsp_config[server].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


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

lsp_config.sumneko_lua.setup {
  cmd = {'lua_language_server.sh'};
  on_attach = on_attach,
  capabilities = capabilities,

  unpack(require("modules._lsp.lua")),
}

-- lsp_config.efm.setup {
--   init_options = {documentFormatting = true},
--   settings = {
--     rootMarkers = {".git/"},
--     languages = {
--       lua = {
--         {formatCommand = "lua-format -i", formatStdin = true}
--       }
--     }
--   }
-- }

