local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.opt.completeopt = "menu,menuone,noinsert"

local compare = cmp.config.compare

local can_expand_or_advance = function()
  return luasnip.expand_or_jumpable()
end

local expand_or_advance = function()
  luasnip.expand()
end

local can_jump = function(direction)
  return luasnip.jumpable(direction)
end

local jump = function(direction)
  luasnip.jump(direction)
end

local types = require('cmp.types')

cmp.setup({
  enabled = function ()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
    or require("cmp_dap").is_dap_buffer()
  end,
  window = {
    completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    }
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })

      vim_item.kind = " " .. strings[1] .. " "
      vim_item.menu = "    (" .. strings[2] .. ")"

      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        treesitter = "[Treesitter]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]

      vim_item.dup = ({
        luasnip = 1,
        nvim_lsp = 1
      })[entry.source.name] or 0

      return vim_item
    end
  },
  -- view = {
  --   entries = "wildmenu",
  -- },
  experimental = {
    ghost_text = false
  },
  completion = {
    -- keyword_length = 1,
    -- autocomplete = false,
    -- completeopt = 'menu,menuone,noinsert',
  },
  preselect = cmp.PreselectMode.Item,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sorting = {
    priority_weight = 2.0,
    comparators = {
      compare.score,
      compare.length,
      compare.offset,
      compare.exact,
      -- compare.order,
      -- compare.locality,
      -- compare.recently_used,
      -- compare.kind,
      -- compare.sort_text,
    },
  },
  mapping = {
    ["<tab>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({select = true})
        elseif can_expand_or_advance() then
          expand_or_advance()
        elseif has_words_before() then
          cmp.complete()
          -- TODO filter the last accepted completion (i.e. instantly accept the second entry)
        else
          fallback()
        end
      end,
      c = function()
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      end
    }),
    ["<s-tab>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif can_jump(-1) then
          previous()
        else
          fallback()
        end
      end,
      c = function()
        cmp.select_prev_item({ behaviour = cmp.SelectBehavior.Insert })
      end
    }),
    ["<cr>"] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() ~= nil then
        cmp.confirm()
      else
        fallback()
      end
    end),
    ["<c-j>"] = cmp.mapping(function(fallback)
      if cmp.core.view.docs_view:visible() then
        cmp.mapping(cmp.scroll_docs(4))
      elseif can_jump(1) then
        jump(1)
      else
        fallback()
      end
    end),
    ["<c-k>"] = cmp.mapping(function(fallback)
      if cmp.core.view.docs_view:visible() then
        cmp.mapping(cmp.scroll_docs(-4))
      elseif can_jump(-1) then
        jump(-1)
      else
        fallback()
      end
    end),
    ["<up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
    ["<down>"] = cmp.mapping( function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
    ["<C-n>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Down>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ["<C-p>"] = cmp.mapping({
      c = function()
        test = 123
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t("<Up>"), "n", true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ["<c-e>"] = cmp.mapping.close()
  },
  sources = {
    { name = "nvim_lsp", filter = function(entry, ctx)
      local kind = types.lsp.CompletionItemKind[entry:get_kind()]

      if kind == "Keyword" then
        return true
      elseif kind == "Text" then
        return true
      end
      return false
    end},
    { name = "dap" },
    { name = "git" },
    { name = "commit" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }
})

cmp.setup.cmdline("/", {
  view = {
    entries = "wildmenu"
  },
  sources = cmp.config.sources({
    {
      { name = 'nvim_lsp_document_symbol', max_item_count = 10 }
    }, {
      { name = 'buffer', max_item_count = 10 }
    }
  })
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
  view = {
    entries = "wildmenu"
  },
  sources = cmp.config.sources({
    { name = "path", max_item_count = 7 },
    { name = "cmdline", max_item_count = 15 }
  })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local handlers = "nvim-autopairs.completion.handlers"

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
  filetypes = {
    -- "*" is a alias to all filetypes
    ["*"] = {
      ["("] = {
        kind = {
          cmp.lsp.CompletionItemKind.Function,
          cmp.lsp.CompletionItemKind.Method,
        },
        handler = handlers["*"]
      }
    },
    ruby = false,
    -- TODO special ruby handler which doesnt add parenthesis for functions or
    -- or simply disable it for ruby
    -- methods with parameters
    --lua = {
    --  ["("] = {
    --    kind = {
    --      cmp.lsp.CompletionItemKind.Function,
    --      cmp.lsp.CompletionItemKind.Method
    --    },
    --    ---@param char string
    --    ---@param item item completion
    --    ---@param bufnr buffer number
    --    handler = function(char, item, bufnr)
    --      print(
    --        cmp.lsp.CompletionItemKind.Function,
    --        cmp.lsp.CompletionItemKind.Method
    --      )
    --      print(vim.inspect{char, item, bufnr})
    --    end
    --  }
    --},
    -- Disable for tex
    tex = false
  }
})
)
