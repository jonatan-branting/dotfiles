vim.o.completeopt = "menuone,noselect"
local compe = require("compe")

compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  border = "rounded",
  min_length = 2,
  preselect = 'enable',
  throttle_time = 200,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = {kind = " Path"},
    buffer = {kind = " Buffer"},
    calc = false, --{kind = " Calc"},
    vsnip = false, --{kind = " Snippet"},
    ultisnips = {kind = " UltiSnips"},
    treesitter = false, --{kind = " TS"},
    lsp = {kind = " LSP", ignored_filetypes = { ".vue", "Vue", "vue" }},
    spell = false,--{kind = " Spell"},
    vim_dadbod_completion = false,
    nvim_lsp = true,
    nvim_lua = false,
    tags = false,
  }
}

local function filter_by_kind(response)
  filtered_kinds = {14} -- Keyword

  filtered_response = {}
  for i, completion_item in ipairs(response.items or response) do
    for j, kind in ipairs(filtered_kinds) do
      if kind == completion_item.kind then goto continue end
    end

    table.insert(filtered_response, completion_item)

    ::continue::
  end

  return filtered_response
end

-- Overwrite internal compe lsp source function to filter completion results by kind
-- require("compe_nvim_lsp.source").complete = function(self, args)
--   if vim.lsp.client_is_stopped(self.client.id) then
--     return args.abort()
--   end

--   local request = vim.lsp.util.make_position_params()
--   request.context = {}
--   request.context.triggerKind = (args.trigger_character_offset > 0 and 2 or (args.incomplete and 3 or 1))
--   if args.trigger_character_offset > 0 then
--     request.context.triggerCharacter = args.context.before_char
--   end

--   self.client.request('textDocument/completion', request, function(err, _, response)
--     if err or response == nil then
--       return args.abort()
--     end

--     args.callback(compe.helper.convert_lsp({
--       keyword_pattern_offset = args.keyword_pattern_offset,
--       context = args.context,
--       request = request,
--       response = filter_by_kind(response),
--     }))
--   end)
-- end

-- Bind tab/s-tab to jump and accept

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

-- TODO: Bind only when filetype isn't Telescope
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
