local actions = require "fzf-lua.actions"
local prompt = "%"
local color_icons = false
local file_icons = false

local flip_columns = 120

require("fzf-lua").setup {
  -- fzf_bin         = 'sk',            -- use skim instead of fzf?
  -- https://github.com/lotabout/skim
  global_resume      = true,            -- enable global `resume`?
  -- can also be sent individually:
  -- `<any_function>.({ gl ... })`
  global_resume_query = true,           -- include typed query in `resume`?
  winopts = {
    -- split         = "belowright new",-- open in a split instead?
    -- "belowright new"  : split below
    -- "aboveleft new"   : split above
    -- "belowright vnew" : split right
    -- "aboveleft vnew   : split left
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined, default)
    height           = 0.88,            -- window height
    width            = 0.88,            -- window width
    row              = 0.35,            -- window row position (0=top, 1=bottom)
    col              = 0.50,            -- window col position (0=left, 1=right)
    -- border argument passthrough to nvim_open_win(), also used
    -- to manually draw the border characters around the preview
    -- window, can be set to 'false' to remove all borders or to
    -- 'none', 'single', 'double', 'thicc' or 'rounded' (default)
    -- border           =  { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },--"rounded", -- { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    -- border = "solid",
    -- border           = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
    fullscreen       = false,           -- start fullscreen?
    hl = {
      normal         = 'NormalFloat',        -- window normal color (fg+bg)
      border         = 'FloatBorder',        -- border color (try 'FloatBorder')
      -- Only valid with the builtin previewer:
      cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
      cursorline     = 'CursorLine',    -- cursor line
      cursorlinenr   = 'CursorLineNr',  -- cursor line number
      search         = 'IncSearch',     -- search matches (ctags|help)
      title          = 'NormalFloat',        -- preview border title (file/buffer)
      -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
      -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
    },
    preview = {
      -- default     = 'default',           -- override the default previewer?
      -- default uses the 'builtin' previewer
      border         = 'border',        -- border|noborder, applies only to
      -- native fzf previewers (bat/cat/git/etc)
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:45%',      -- up|down:size
      horizontal     = 'right:52%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = flip_columns,             -- #cols to switch to horizontal on flex
      -- Only valid with the builtin previewer:
      title          = false,            -- preview border title (file/buf)?
      scrollbar      = false,         -- `false` or string:'float|border'
      -- float:  in-window floating border
      -- border: in-border chars (see below)
      scrolloff      = '-2',            -- float scrollbar offset from right
      -- applies only when scrollbar = 'float'
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
      -- applies only when scrollbar = 'border'
      delay          = 30,             -- delay(ms) displaying the preview
      -- prevents lag on fast scrolling
      winopts = {                       -- builtin previewer window options
        number            = true,
        relativenumber    = false,
        cursorline        = true,
        cursorlineopt     = 'both',
        cursorcolumn      = false,
        signcolumn        = 'no',
        list              = false,
        foldenable        = false,
        foldmethod        = 'manual',
      },
    },
    on_create = function()
      -- TODO: pass winnr as parameter
      local win = vim.api.nvim_get_current_win()

      local row, col = unpack(vim.api.nvim_win_get_position(win))

      -- Add a small gap between preview and fzf
      if vim.go.columns < flip_columns then
        -- vim.api.nvim_win_set_config(win, {
        --   col = col,
        --   row = row - 1,
        --   relative = "editor",
        -- })
      else
        -- vim.api.nvim_win_set_config(win, {
        --   col = col - 1,
        --   row = row ,
        --   relative = "editor",
        -- })
      end
      vim.b.miniindentscope_disable = true
      -- vim.cmd("set winblend=10")
      -- called once upon creation of the fzf main window
      -- can be used to add custom fzf-lua mappings, e.g:
      --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
      --     { silent = true, noremap = true })
    end,
  },
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]        = "toggle-help",
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
    },
  },
  actions = {
    -- These override the default tables completely
    -- no need to set to `false` to disable an action
    -- delete or modify is sufficient
    files = {
      -- providers that inherit these actions:
      --   files, git_files, git_status, grep, lsp
      --   oldfiles, quickfix, loclist, tags, btags
      --   args
      -- default action opens a single selection
      -- or sends multiple selection to quickfix
      -- replace the default action with the below
      -- to open all files whether single or multiple
      -- ["default"]     = actions.file_edit,
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      -- ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
    },
    buffers = {
      -- providers that inherit these actions:
      --   buffers, tabs, lines, blines
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  fzf_opts = {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--height']      = '100%',
    ['--layout']      = 'default',
    ['--border']      = 'none',
    ['--pointer']     = '\\ '
  },
  -- fzf '--color=' options (optional)
  fzf_colors = {
      ["fg"]          = { "fg", "Normal" },
      ["bg"]          = { "bg", "NormalFloat" },
      ["hl"]          = { "fg", "Title" },
      ["fg+"]         = { "fg", "Normal" },
      ["bg+"]         = { "bg", "PmenuSbar" },
      ["hl+"]         = { "fg", "Title" },
      ["info"]        = { "fg", "PreProc" },
      ["prompt"]      = { "fg", "Conditional" },
      ["pointer"]     = { "fg", "Conditional" },
      ["marker"]      = { "fg", "Keyword" },
      ["spinner"]     = { "fg", "Label" },
      ["header"]      = { "fg", "Comment" },
      ["gutter"]      = { "bg", "NormalFloat" },
  },
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- pager        = "delta",      -- if you have `delta` installed
    },
    man = {
      -- NOTE: remove the `-c` flag when using man-db
      cmd             = "man -c %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
      -- preview extensions using a custom shell command:
      -- for example, use `viu` for image previews
      -- will do nothing if `viu` isn't executable
      extensions      = {
        -- neovim terminal only supports `viu` block output
        ["png"]       = { "viu", "-b" },
        ["jpg"]       = { "ueberzug" },
      },
      -- if using `ueberzug` in the above extensions map
      -- set the default image scaler, possible scalers:
      --   false (none), "crop", "distort", "fit_contain",
      --   "contain", "forced_cover", "cover"
      -- https://github.com/seebye/ueberzug
      ueberzug_scaler = "cover",
    },
  },
  -- provider setup
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
    -- (name from 'previewers' table)
    -- set to 'false' to disable
    -- prompt            = 'Files> ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = file_icons,           -- show file icons?
    color_icons       = color_icons,           -- colorize file|git icons
    -- path_shorten   = 1,              -- 'true' or number, shorten path?
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
    -- default options are controlled by 'fd|rg|find|_opts'
    -- NOTE: 'find -printf' requires GNU find
    -- cmd            = "find . -type f -printf '%P\n'",
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts           = "--color=never --type f --hidden --follow --exclude .git",
    actions = {
      -- inherits from 'actions.files', here we can override
      -- or set bind to 'false' to disable a default action
      ["default"]     = actions.file_edit,
      -- custom actions are available too
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  git = {
    files = {
      prompt          = 'GitFiles> ',
      cmd             = 'git ls-files --exclude-standard',
      multiprocess    = true,           -- run command in a separate process
      git_icons       = true,           -- show git icons?
      file_icons      = file_icons,           -- show file icons?
      color_icons     = color_icons,           -- colorize file|git icons
      -- force display the cwd header line regardles of your current working
      -- directory can also be used to hide the header when not wanted
      -- show_cwd_header = true
    },
    status = {
      prompt          = 'GitStatus> ',
      cmd             = "git status -s",
      previewer       = "git_diff",
      file_icons      = file_icons,
      git_icons       = true,
      color_icons     = color_icons,
      actions = {
        -- actions inherit from 'actions.files' and merge
        ["right"]   = { actions.git_unstage, actions.resume },
        ["left"]    = { actions.git_stage, actions.resume },
      },
    },
    commits = {
      prompt          = 'Commits> ',
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      prompt          = 'BCommits> ',
      cmd             = "git log --pretty=oneline --abbrev-commit --color",
      preview         = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      prompt          = 'Branches> ',
      cmd             = "git branch --all --color",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {
        ["default"] = actions.git_switch,
      },
    },
    stash = {
      prompt          = 'Stash> ',
      cmd             = "git --no-pager stash list",
      preview         = "git --no-pager stash show --patch --color {1}",
      actions = {
        ["default"]   = actions.git_stash_apply,
        ["ctrl-x"]    = { actions.git_stash_drop, actions.resume },
      },
      fzf_opts = {
        ["--no-multi"]  = '',
        ['--delimiter'] = "'[:]'",
      },
    },
    icons = {
      ["M"]           = { icon = "M", color = "yellow" },
      ["D"]           = { icon = "D", color = "red" },
      ["A"]           = { icon = "A", color = "green" },
      ["R"]           = { icon = "R", color = "yellow" },
      ["C"]           = { icon = "C", color = "yellow" },
      ["T"]           = { icon = "T", color = "magenta" },
      ["?"]           = { icon = "?", color = "magenta" },
      -- override git icons?
      -- ["M"]        = { icon = "★", color = "red" },
      -- ["D"]        = { icon = "✗", color = "red" },
      -- ["A"]        = { icon = "+", color = "green" },
    },
  },
  grep = {
    prompt            = 'Rg> ',
    input_prompt      = 'Grep For> ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = file_icons,           -- show file icons?
    color_icons       = color_icons,           -- colorize file|git icons
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `rg` over `grep`
    -- default options are controlled by 'rg|grep_opts'
    -- cmd            = "rg --vimgrep",
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
    rg_opts           = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
    -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
    -- search strings will be split using the 'glob_separator' and translated
    -- to '--iglob=' arguments, requires 'rg'
    -- can still be used when 'false' by calling 'live_grep_glob' directly
    rg_glob           = false,        -- default to glob parsing?
    glob_flag         = "--iglob",    -- for case sensitive globs use '--glob'
    glob_separator    = "%s%-%-",     -- query separator pattern (lua): ' --'
    -- advanced usage: for custom argument parsing define
    -- 'rg_glob_fn' to return a pair:
    --   first returned argument is the new search query
    --   second returned argument are addtional rg flags
    -- rg_glob_fn = function(query, opts)
    --   ...
    --   return new_query, flags
    -- end,
    actions = {
      -- actions inherit from 'actions.files' and merge
      -- this action toggles between 'grep' and 'live_grep'
      ["ctrl-g"]      = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  args = {
    prompt            = 'Args> ',
    files_only        = true,
    -- actions inherit from 'actions.files' and merge
    actions           = { ["ctrl-x"] = { actions.arg_del, actions.resume } }
  },
  oldfiles = {
    prompt            = 'History> ',
    cwd_only          = false,
    file_icons = file_icons,
    color_icons = color_icons,
    stat_file         = true,         -- verify files exist on disk
    include_current_session = false,  -- include bufs from current session
  },
  buffers = {
    prompt            = 'Buffers> ',
    file_icons        = file_icons,         -- show file icons?
    color_icons       = color_icons,         -- colorize file|git icons
    sort_lastused     = true,         -- sort buffers() by last used
    actions = {
      -- actions inherit from 'actions.buffers' and merge
      -- by supplying a table of functions we're telling
      -- fzf-lua to not close the fzf window, this way we
      -- can resume the buffers picker on the same window
      -- eliminating an otherwise unaesthetic win "flash"
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    }
  },
  tabs = {
    prompt            = 'Tabs> ',
    tab_title         = "Tab",
    tab_marker        = "<<",
    file_icons        = file_icons,         -- show file icons?
    color_icons       = color_icons,         -- colorize file|git icons
    actions = {
      -- actions inherit from 'actions.buffers' and merge
      ["default"]     = actions.buf_switch,
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    },
    fzf_opts = {
      -- hide tabnr
      ['--delimiter'] = "'[\\):]'",
      ["--with-nth"]  = '2..',
    },
  },
  lines = {
    previewer         = "builtin",    -- set to 'false' to disable
    prompt            = 'Lines> ',
    show_unlisted     = false,        -- exclude 'help' buffers
    no_term_buffers   = true,         -- exclude 'term' buffers
    fzf_opts = {
      -- do not include bufnr in fuzzy matching
      -- tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--nth"]       = '2..',
      ["--tiebreak"]  = 'index',
    },
    -- actions inherit from 'actions.buffers' and merge
    actions = {
      ["default"]     = { actions.buf_edit_or_qf },
      ["alt-q"]       = { actions.buf_sel_to_qf }
    },
  },
  blines = {
    previewer         = "builtin",    -- set to 'false' to disable
    prompt            = 'BLines> ',
    show_unlisted     = true,         -- include 'help' buffers
    no_term_buffers   = false,        -- include 'term' buffers
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--with-nth"]  = '2..',
      ["--tiebreak"]  = 'index',
    },
    -- actions inherit from 'actions.buffers' and merge
    actions = {
      ["default"]     = { actions.buf_edit_or_qf },
      ["alt-q"]       = { actions.buf_sel_to_qf }
    },
  },
  tags = {
    prompt                = 'Tags> ',
    ctags_file            = "tags",
    multiprocess          = true,
    file_icons            = file_icons,
    git_icons             = true,
    color_icons           = color_icons,
    -- 'tags_live_grep' options, `rg` prioritizes over `grep`
    rg_opts               = "--no-heading --color=always --smart-case",
    grep_opts             = "--color=auto --perl-regexp",
    actions = {
      -- actions inherit from 'actions.files' and merge
      -- this action toggles between 'grep' and 'live_grep'
      ["ctrl-g"]          = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  btags = {
    prompt                = 'BTags> ',
    ctags_file            = "tags",
    multiprocess          = true,
    file_icons            = file_icons,
    git_icons             = true,
    color_icons           = color_icons,
    rg_opts               = "--no-heading --color=always",
    grep_opts             = "--color=auto --perl-regexp",
    fzf_opts = {
      ['--delimiter']     = "'[\\]:]'",
      ["--with-nth"]      = '2..',
      ["--tiebreak"]      = 'index',
    },
    -- actions inherit from 'actions.files'
  },
  colorschemes = {
    prompt            = 'Colorschemes> ',
    live_preview      = true,       -- apply the colorscheme on preview?
    actions           = { ["default"] = actions.colorscheme, },
    winopts           = { height = 0.55, width = 0.30, },
    post_reset_cb     = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end,
  },
  quickfix = {
    file_icons        = file_icons,
    git_icons         = true,
  },
  lsp = {
    prompt_postfix    = '> ',       -- will be appended to the LSP label
    -- to override use 'prompt' instead
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = 5000,       -- timeout(ms) or 'true' for async calls
    file_icons        = file_icons,
    git_icons         = false,
    ui_select         = true,       -- use 'vim.ui.select' for code actions
    -- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
    symbols = {
      async_or_timeout  = true,       -- symbols are async by default
      symbol_style      = 1,          -- style for document/workspace symbols
      -- false: disable,    1: icon+kind
      --     2: icon only,  3: kind only
      -- NOTE: icons are extracted from
      -- vim.lsp.protocol.CompletionItemKind
      -- colorize using nvim-cmp's CmpItemKindXXX highlights
      -- can also be set to 'TS' for treesitter highlights ('TSProperty', etc)
      -- or 'false' to disable highlighting
      symbol_hl_prefix  = "CmpItemKind",
      -- additional symbol formatting, works with or without style
      symbol_fmt        = function(s) return "["..s.."]" end,
    },
  },
  diagnostics ={
    prompt            = 'Diagnostics> ',
    cwd_only          = true,      -- limit to cwd only?
    file_icons        = file_icons,
    git_icons         = false,
    diag_icons        = true,
    severity_icons = {
      ["Error"]       = { icon = "", color = "red" },
      ["Warning"]     = { icon = "", color = "yellow" },
      ["Information"] = { icon = "", color = "blue" },
      ["Hint"]        = { icon = "", color = "magenta" },
    },
    -- limit to specific severity, use either a string or num:
    --   1 or "hint"
    --   2 or "information"
    --   3 or "warning"
    --   4 or "error"
    -- severity_only:   keep any matching exact severity
    -- severity_limit:  keep any equal or more severe (lower)
    -- severity_bound:  keep any equal or less severe (higher)
  },
  -- uncomment to use the old help previewer which used a
  -- minimized help window to generate the help tag preview
  -- helptags = { previewer = "help_tags" },
  -- uncomment to use `man` command as native fzf previewer
  -- (instead of using a neovim floating window)
  -- manpages = { previewer = "man_native" },
  -- 
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  file_icon_colors = {
    ["sh"] = "green",
  },
  -- padding can help kitty term users with
  -- double-width icon rendering
  file_icon_padding = '',
  -- uncomment if your terminal/font does not support unicode character
  -- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
  -- nbsp = '\xc2\xa0',
}
