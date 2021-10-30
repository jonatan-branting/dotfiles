local cmp = require("cmp")
local lspkind = require("lspkind")

vim.o.complete = ""

cmp.setup({
    formatting = {
      format = lspkind.cmp_format({with_text = true, menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
        })}),
    },
    completion = {
      completeopt = "menu,menuone,noselect"
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end
    },
    mapping = {
      ["<cr>"] = cmp.mapping.confirm(),
      ["<tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ["<s-tab>"] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "treesitter" },
      { name = "ultisnips" },
      { name = "buffer", max_item_count = 4 },
      { name = "path" },
    }
  })
