local queries = require "nvim-treesitter.query"
local gen_spec = require("mini.ai").gen_spec

require("mini.ai").setup({
  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = {
    -- argument
    a = gen_spec.argument({ brackets = { "%b()", "%b{}" }, separators = { ',', ';' } }),
    b = { {"%b[]", "%b()", "%b{}" } },
    -- digits
    d = { '%f[%d]%d+' },
    -- diagnostics (errors)
    f = gen_spec.treesitter({
        a = { "@function.outer" },
        i = { "@function.inner" },
      }
    ),
    -- scope
    s = gen_spec.treesitter({
        a = { "@function.outer", "@class.outer" },
        i = { "@function.inner", "@class.inner" },
      }
    ),
    x = { {
      '\n()%s*().-()\n()',
      '^()%s*().-()\n()'
    } },
    -- WORD
    -- W = { {
    --   '()()%f[%w%p][%w%p]+()[ \t]*()',
    -- } },
    -- word
    -- w = { '()()%f[%w]%w+()[ \t]*()' },
    -- key or value (needs a lot of work)
    -- z = gen_spec.argument({ brackets = { '%b()'}, separators = {',', ';', '=>'}}),
    -- chunk (as in from vim-textobj-chunk)
    -- z = {
    --     '\n.-%b{}',
    --     '\n().-%{\n().*()\n.*%}()'
    -- },
  },
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',
    -- Next/last textobjects
    -- TODO create goto next 
    -- TODO around/inside `remote`... somehow... mini extension?
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',
    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },
  -- Number of lines within which textobject is searched
  n_lines = 300,
  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = 'cover_or_next',
})

for _, k in ipairs({ "]", "}", ">", "o", "f", "r", "b" }) do
  for _, mode in ipairs({ 'n', 'x', 'o' }) do
    vim.api.nvim_set_keymap(
      mode, ']' .. k, [[<Cmd>lua MiniAi.move_cursor('left', 'a',']]  .. vim.fn.escape(k, "'") .. [[', { search_method = 'next' })<CR>]], {}
    )
    -- print([[<Cmd>lua MiniAi.move_cursor('left', 'a',']]  .. vim.fn.escape(k, "'") .. [[', { search_method = 'next' })<CR>]])
    -- print([[<Cmd>lua MiniAi.move_cursor('left', 'a',]]  .. k .. [[, { search_method = 'next' })<CR>]])
  end
end

require('mini.trailspace').setup({
  -- Table with textobject id as fields, textobject specification as values.
  -- Also use this to disable builtin textobjects. See |MiniAi.config|.
  custom_textobjects = nil,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Main textobject prefixes
    around = 'a',
    inside = 'i',

    -- Next/last textobjects
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',

    -- Move cursor to corresponding edge of `a` textobject
    goto_left = 'g[',
    goto_right = 'g]',
  },

  -- Number of lines within which textobject is searched
  n_lines = 50,

  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = 'cover_or_next',
})
-- require("mini.surround").setup({
--   -- Add custom surroundings to be used on top of builtin ones. For more
--   -- information with examples, see `:h MiniSurround.config`.
--   custom_surroundings = nil,

--   -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
--   highlight_duration = 500,

--   -- Module mappings. Use `''` (empty string) to disable one.
--   mappings = {
--     add = 'ys', -- Add surrounding in Normal and Visual modes
--     delete = 'ds', -- Delete surrounding
--     find = 'sf', -- Find surrounding (to the right)
--     find_left = 'sF', -- Find surrounding (to the left)
--     highlight = 'sh', -- Highlight surrounding
--     replace = 'cs', -- Replace surrounding
--     update_n_lines = 'sn', -- Update `n_lines`
--   },

--   -- Number of lines within which surrounding is searched
--   n_lines = 500,

--   -- How to search for surrounding (first inside current line, then inside
--   -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
--   -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
--   search_method = 'cover_or_next',
-- })
require('mini.sessions').setup({
  -- Whether to read latest session if Neovim opened without file arguments
  autoread = false,

  -- Whether to write current session before quitting Neovim
  autowrite = true,

  -- Directory where global sessions are stored (use `''` to disable)
  directory = "~/.local/share/nvim/sessions/",

  -- File for local session (use `''` to disable)
  file = 'Session.vim',

  -- Whether to force possibly harmful actions (meaning depends on function)
  force = { read = false, write = true, delete = false },

  -- Hook functions for actions. Default `nil` means 'do nothing'.
  hooks = {
    -- Before successful action
    pre = { read = nil, write = nil, delete = nil },
    -- After successful action
    post = { read = nil, write = nil, delete = nil },
  },

  -- Whether to print session path after action
  verbose = { read = false, write = true, delete = true },
})
local starter = require('mini.starter')
starter.setup({
  evaluate_single = true,
  items = {
    -- {action = 'FzfLua file_browser',    name = 'Browser',         section = 'Telescope'},
    -- {action = 'FzfLua command_history', name = 'Command history', section = 'FZF'},
    -- {action = 'FzfLua files',           name = 'Files',           section = 'FZF'},
    -- {action = 'FzfLua help_tags',       name = 'Help tags',       section = 'FZF'},
    -- {action = 'FzfLua live_grep',       name = 'Live grep',       section = 'FZF'},
    -- {action = 'FzfLua oldfiles',        name = 'Old files',       section = 'FZF'},

    starter.sections.builtin_actions(),
    starter.sections.recent_files(10, false),
    starter.sections.recent_files(10, true),
    -- Use this if you set up 'mini.sessions'
    starter.sections.sessions(5, true)
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Builtin actions' }),
    starter.gen_hook.aligning('center', 'center'),
    starter.gen_hook.padding(4, 2),
  },
})

-- require("mini.root").setup({

-- })

require("mini.indentscope").setup({
    draw = {
      -- Delay (in ms) between event and start of drawing scope indicator
      delay = 50,

      -- Animation rule for scope's first drawing. A function which, given next
      -- and total step numbers, returns wait time (in ms). See
      -- |MiniIndentscope.gen_animation()| for builtin options. To not use
      -- animation, supply `require('mini.indentscope').gen_animation('none')`.
      animation = require("mini.indentscope").gen_animation("none")
    },

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Textobjects
      object_scope = 'is',
      object_scope_with_border = 'as',

      -- Motions (jump to respective border line; if not present - body line)
      goto_top = '[s',
      goto_bottom = ']s',
    },

    -- Options which control computation of scope. Buffer local values can be
    -- supplied in buffer variable `vim.b.miniindentscope_options`.
    options = {
      -- Type of scope's border: which line(s) with smaller indent to
      -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
      border = 'both',

      -- Whether to use cursor column when computing reference indent. Useful to
      -- see incremental scopes with horizontal cursor movements.
      indent_at_cursor = true,

      -- Whether to first check input line to be a border of adjacent scope.
      -- Use it if you want to place cursor on function header to get scope of
      -- its body.
      try_as_border = false,
    },

    -- Which character to use for drawing scope indicator
    symbol = ':',
  }
)
