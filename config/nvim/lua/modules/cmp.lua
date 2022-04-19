local cmp = require("cmp")
local lspkind = require("lspkind")
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
--
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.opt.completeopt = "menu,menuone,noselect,noinsert"

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
    keyword_length = 1
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
  mapping = {
    ["<cr>"] = cmp.mapping.confirm({ select = true }),
    -- ['<cr>'] = cmp.mapping({
    --   i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
    --   end
    -- }),
    ['<c-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-k>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ["<Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        elseif has_words_before() then
          vim.complete()
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
          cmp.complete()
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
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
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
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
    ["<c-e>"] = cmp.mapping.close(),
    ["<c-Space>"] = cmp.mapping.complete(),
    -- ["<tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.mapping.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<s-tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.mapping.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "ultisnips" },
    { name = "treesitter" },
    { name = "buffer", max_item_count = 4 },
    { name = "path", max_item_count = 4  },
  }
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer', max_item_count = 10 }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path', max_item_count = 7 },
    { name = 'cmdline', max_item_count = 15 }
  })
})


local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
