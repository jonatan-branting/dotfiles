local cmp = require("cmp")
local lspkind = require("lspkind")
local snippy = require("snippy")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.opt.completeopt = "menu,menuone,noinsert"

local compare = cmp.config.compare

cmp.setup({
  -- preselect = cmp.PreselectMode.None,
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
    keyword_length = 1,
    autocomplete = false,
    completeopt = 'menu,menuone,noinsert',
  },
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.score,
      compare.locality,
      compare.exact,
      compare.offset,
      compare.order,
      compare.recently_used,
      compare.kind,
      -- compare.sort_text,
      compare.length,
    },
  },
  mapping = {
    ["<tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<s-tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["{"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    ["("] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    [":"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    [";"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    [","] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    ["."] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i" }),
    ["<space>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({}, function()
          fallback()
        end)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<cr>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<c-j>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<c-k>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<up>"] = cmp.mapping({
      c = function()
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
    ["<down>"] = cmp.mapping({
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
    { name = "nvim_lsp" },
    { name = "snippy" },
    { name = "treesitter" },
    { name = "buffer", max_item_count = 4 },
    { name = "path", max_item_count = 4  },
  }
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer", max_item_count = 10 }
  }
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path", max_item_count = 7 },
    { name = "cmdline", max_item_count = 15 }
  })
})
