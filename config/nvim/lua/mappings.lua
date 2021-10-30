local keymap = require('astronauta.keymap')
local wk = require("which-key")
local cnoremap = keymap.cnoremap
local vmap = keymap.vmap
local onoremap = keymap.onoremap
local snoremap = keymap.snoremap
local xnoremap = keymap.xnoremap
local nmap = keymap.nmap
local xmap = keymap.xmap
local omap = keymap.omap
local imap = keymap.imap
local tnoremap = keymap.tnoremap

require("which-key").setup {
  plugins = {
    marks = false,
    registers = false,
    presets = {
      operators = true,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  icons = {
    breadcrumb = "-",
    separator = "➜",
    group = "+",
  },
  window = {
    border = "none",
    position = "bottom",
    margin = { 0, 0, 1, 0 },
    padding = { 1, 1, 1, 1 },
  },
  layout = {
    height = { min = 1, max = 15 },
    width = { min = 15, max = 40 },
    spacing = 2,
  },
  show_help = false,
  triggers = { "<leader>", "," },
}

local wk_dict = {
  -- Groups
  ["<leader>r"] = { name = "+ruby" },
  ["<leader>a"] = { name = "+actions" },
  ["<leader>t"] = { name = "+test" },
  -- ["<leader>j"] = { name = "+harpoon" },
  ["<leader>b"] = { name = "+buffers" },
  ["<leader>g"] = { name = "+git" },
  ["<leader>w"] = { name = "+windows" },
  ["<leader>h"] = { name = "+hunks" },
  ["<leader>c"] = { name = "+chrome" },

  -- Otherwise missing descriptions
  ["<leader><Tab>"] = { name = "toggle-terminal" },
  ["<leader>q"] = { name = "format-buffer" },
  ["<leader>n"] = { name = "test-stuff" },
  ["<leader>d"] = { name = "debug" },
}

local function starts_with(str, start)
  return str:sub(1, #start) == start
end

local function nnoremap(opts, desc)
  if starts_with(opts[1], "<leader>") then
    wk_dict[opts[1]] = { desc }
  end

  return keymap.nnoremap(opts)
end

local function inoremap(opts, desc)
  return keymap.inoremap(opts)
end

local function vnoremap(opts, desc)
  return keymap.vnoremap(opts)
end

-- Convenience <leader> mappings
nnoremap({ '<leader>s', ':w<cr>' }, 'save-file')
-- nnoremap({ '<leader>x', ':x<cr>' }, 'save-and-exit')

-- General opinionated behaviour changes
-- Make Enter open a line in normal mode, above or below, respectively
nnoremap({ '<cr>', 'o<esc>' }, 'open-line-below')
nnoremap({ '<s-cr>', 'O<esc>' }, 'open-line-above')

inoremap({ 'jj', '<esc>' }, 'escape')
snoremap({ 'jj', '<esc>' })
cnoremap({ 'jj', '<esc>' }, 'escape')
tnoremap({ 'jj', '<c-\\><c-n>' }, 'escape')

nnoremap({ '<silent><expr> k', "(v:count == 0 ? 'gk' : 'k')" })
nnoremap({ '<silent><expr> j', "(v:count == 0 ? 'gj' : 'j')" })
vnoremap({ '<silent><expr> k', "(v:count == 0 ? 'gk' : 'k')" })
vnoremap({ '<silent><expr> j', "(v:count == 0 ? 'gj' : 'j')" })
-- nnoremap({ 'L', 'g$' })
nnoremap({ 'H', 'g^' })

-- TODO g0 first, then the other behaviour!
vim.api.nvim_set_keymap('n', 'H', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})
vim.api.nvim_set_keymap('v', 'H', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

vnoremap({ 'L', 'g$' })
-- vnoremap({ 'H', 'g^' })
vnoremap({ '>', '>gv' })
vnoremap({ '<', '<gv' })

-- TODO: This [the visual-mode version] does not work properly when total_width = cursor_line_pos
vnoremap({ 'L',
    function()
      if vim.wo.wrap then
        return vim.cmd [[normal g$]]
      end

      local total_width = vim.fn.virtcol("$") - 1
      local cursor_line_pos = vim.fn.virtcol(".")
      local cursor_window_pos = vim.fn.wincol()
      local window_width = vim.fn.winwidth(0)

      if total_width == cursor_line_pos then
        return vim.cmd [[normal 0g$]]
      elseif cursor_window_pos == window_width then
        return vim.cmd [[normal $]]
      else
        return vim.cmd [[normal g$]]
      end
    end
}, '')


nnoremap({ 'L',
    function()
      if vim.wo.wrap then
        return vim.cmd [[normal g$]]
      end

      local total_width = vim.fn.virtcol("$") - 1
      local cursor_line_pos = vim.fn.virtcol(".")
      local cursor_window_pos = vim.fn.wincol()
      local window_width = vim.fn.winwidth(0)

      if total_width == cursor_line_pos then
        return vim.cmd [[normal 0g$]]
      elseif cursor_window_pos == window_width then
        return vim.cmd [[normal $]]
      else
        return vim.cmd [[normal g$]]
      end
    end
}, '')

nnoremap({ 'p', 'p`[v`]=' })

-- Allow terminal style navigation in insert mode
inoremap({ '<c-e>', '<c-o>g$' }, 'end-of-line')
inoremap({ '<c-a>', '<c-o>g0' }, 'start-of-line')

nnoremap({ 'X', 'vaw' }, 'visual-around-word')

-- Search and replace selection
vnoremap({ '<c-r>', '\"hy:%s/<c-r>h//gc<left><left><left>' }, 'search-and-replace')

-- Consistency please!
nnoremap({ 'vv', '0v$' })
nnoremap({ 'Y', 'y$' })

-- Run last macro using ,
nnoremap({ ',', '@@' }, 'rerun-macro')

-- Break undo sequences
inoremap({ ',', ',<c-g>u'})
inoremap({ '.', '.<c-g>u'})
inoremap({ '!', '!<c-g>u'})
inoremap({ '?', '?<c-g>u'})

-- Terminal (Non-ANSI layouts make the default keybindings abysmal)
-- tnoremap({ '<esc>', '<c-\\><c-n>' })

-- Reload easily
nnoremap({ '<leader>R', ':Reload<cr>' })

-- Windows
nnoremap({ '<leader>ww', '<c-w>w' }, '?')
nnoremap({ '<leader>wd', '<c-w>c' }, 'delete-window')
nnoremap({ '<leader>w-', '<c-w>s' }, 'horizontal-split')
nnoremap({ '<leader>w/', '<c-w>v' }, 'vertical-split')
nnoremap({ '<leader>wh', '<c-w>h' }, 'window-left')
nnoremap({ '<leader>wj', '<c-w>j' }, 'window-below')
nnoremap({ '<leader>wk', '<c-w>k' }, 'window-up')
nnoremap({ '<leader>wl', '<c-w>l' }, 'window-down')
nnoremap({ '<leader>w<space>', '<c-w>m' }, 'zoom-window')
nnoremap({ '<leader>wH', '<c-w>5<' }, 'enlargen-window-left')
nnoremap({ '<leader>wL', '<c-w>5>' }, 'enlargen-window-right')
nnoremap({ '<leader>wy', '<c-w>H' }, 'semi-rotate-layout')
nnoremap({ '<leader>w=', '<c-w>=' }, 'balance-windows')
nnoremap({ '<leader>wg', ':GoldenRatioResize<cr>' }, 'golden-ratio')
nnoremap({ '<leader>we', ':GoldenRatioResize<cr>' }, 'golden-ratio')

-- Buffers
nnoremap({ '<leader>bd', ':bd<cr>' }, 'delete-buffer')
nnoremap({ '<leader>bh', ':Startify<cr>' }, 'start-screen/home')
nnoremap({ '<leader>bn', ':bnext<cr>' }, 'next-buffer')
nnoremap({ '<leader>bp', ':bprev<cr>' }, 'prev-buffer')

-- Quickfix
nnoremap({ '<leader>qn', ':cnext<cr>' }, 'quickfix-next')
nnoremap({ '<leader>qn', ':cprev<cr>' }, 'quickfix-prev')

-- Telescope, remove, or add again when it's better than fzf
local telescope = require('telescope.builtin')
local telescope_bindings = {
  find_files = function(opts) telescope.find_files(opts) end,
  find_files_in_folder = function(opts) telescope.find_files(opts) end,
  live_grep = function(opts) telescope.grep_string(opts) end,
  list_buffers = function(opts) telescope.buffers({ sort_lastused = true, ignore_current_buffer = true, unpack(opts or {}) }) end,
  most_recent = function(opts) require('telescope').extensions.frecency.frecency(opts) end,
  grep_string = function(opts) telescope.grep_string(opts) end,
  grep_string_visual = function(opts) telescope.grep_string({search = require"utils".get_visual_selection(), unpack(opts) }) end
}

local hist = require("history")
local actions = require("telescope.actions")

local function telescope_command(cmd)
  local pre = cmd and {} or { pre = actions.cycle_history_prev }

  return function()
    cmd = cmd or hist.get_last_command("telescope")

    local func = (telescope_bindings[cmd] or telescope[cmd])
    if not func then return end

    hist.insert_command("telescope", cmd)

    return func(pre)
  end
end

local function telescope_command(cmd)
  return telescope_bindings[cmd] or telescope[cmd] or error("no telescope action found for: " .. cmd)
end

-- nnoremap({ '<leader>p', telescope_command("find_files") }, 'find-files')
nnoremap({ '<leader>p', ':Files<cr>' }, 'find-files')
nnoremap({ '<leader>i', ':Files<cr>' }, 'find-files')
nnoremap({ '<leader>f', ':Rg<cr>' }, 'live-grep')
nnoremap({ '<leader>e', ':Buffers<cr>' }, 'list-buffers')
-- nnoremap({ '<leader>e', telescope_command("list_buffers") }, 'list-buffers')
nnoremap({ '<leader>m', ':FZFMru<cr>' }, 'most-recent')
-- nnoremap({ '<leader>m', telescope_command("most_recent") }, 'most-recent')
-- nnoremap({ '<leader>l', telescope_command() }, 'telescope-resume')

nnoremap({ 'gw', ':Rg <c-r>=expand("<cword>")<cr><cr>' }, 'grep-cword')

-- nnoremap({ '<leader>e', telescope_command("list_buffers") }, 'list-buffers')
-- nnoremap({ '<leader>p', telescope_command("find_files") }, 'list-files')
-- nnoremap({ '<leader>i', telescope_command("find_files") }, 'list-files-in-folder')
-- nnoremap({ '<leader>f', telescope_command("live_grep") }, 'live-grep')
-- nnoremap({ 'gw', telescope_command("grep_string") }, 'grep-cword')
-- vnoremap({ 'gw', telescope_command("grep_string_visual") }, 'grep-cword')
-- vnoremap({ 'gw', telescope_command("grep_string_visual") }, 'grep-cword')
-- vnoremap({ 'gw', function() vim.cmd("GrepperRg " .. require"utils".get_visual_selection()) end}, 'grep-cword')
-- If this is not an Ex command Telescope will require me to press <esc> to see the results for no apparentreason
vnoremap ({ 'gw',
    function()
      local search = ":Rg " .. require"utils".get_visual_selection()
      print(search)
      vim.cmd(search)
    end
}, 'grep-selected')

nnoremap ({ '<leader>i',
    function()
      local search = ":Files " .. vim.fn.expand('%:h')
      vim.cmd(search)
    end
  }, 'files-in-folder')

-- nnoremap({ '<leader>i', function() telescope.file_browser({cwd = get_current_file_dir()}) end }, 'files-in-dir')

-- Harpoon
-- nnoremap({ '<leader>j', function() require("hop").hint_words() end }, 'hint-words')
-- local harpoon_ui = require('harpoon.ui')
-- local harpoon_term = require('harpoon.term')
-- local harpoon_mark = require('harpoon.mark')
-- nnoremap({ '<leader>jh', function() harpoon_mark.add_file() end }, 'harpoon-file')
-- nnoremap({ '<leader>j1', function() harpoon_ui.nav_file(1) end }, 'goto-harpoon-1')
-- nnoremap({ '<leader>j2', function() harpoon_ui.nav_file(2) end }, 'goto-harpoon-2')
-- nnoremap({ '<leader>j3', function() harpoon_ui.nav_file(3) end }, 'goto-harpoon-3')
-- nnoremap({ '<leader>j4', function() harpoon_ui.nav_file(4) end }, 'goto-harpoon-4')
-- nnoremap({ '<leader>jt', function() harpoon_term.gotoTerminal(1) end }, 'harpoon-terminal')

-- Neoterm
-- nnoremap({ '<leader><tab>', ":tabnext<cr>"})
nnoremap({ '<leader><tab>', ":call WS_Backforth()<cr>"})

-- Git
nnoremap({ '<leader>gc', ':Git commit<cr>' }, 'git-commit')
nnoremap({ '<leader>gl', ':Git log --name-only<cr>' }, 'git-log')
nnoremap({ '<leader>gf', ':Git log --name-only --invert-grep --grep="^fixup!" --pretty="format:%h %Cf"<cr>' }, 'git-log')
nnoremap({ '<leader>gs', ':Git<cr>' }, 'git-status')
nnoremap({ '<leader>gg', ':Git status<cr>' }, 'neogit')
nnoremap({ '<leader>ga', ':Git add %<cr>' }, 'git-add-%')
nnoremap({ '<leader>gd', ':Gdiffsplit master<cr>' }, 'git-diff-split')
nnoremap({ '<leader>gm', ':Git mergetool<cr>' }, 'git-mergetool')


-- GitSigns
local gitsigns =  require('gitsigns')
nnoremap({ '<leader>hs', function() gitsigns.stage_hunk() end }, 'stage-hunk')
nnoremap({ '<leader>hu', function() gitsigns.undo_stage_hunk() end }, 'undo-hunk')
nnoremap({ '<leader>hr', function() gitsigns.reset_hunk() end }, 'reset-hunk')
nnoremap({ '<leader>hR', function() gitsigns.reset_buffer() end }, 'reset-buffer')
nnoremap({ '<leader>hb', function() gitsigns.blame_line() end}, 'blame-line')

nnoremap({ '<leader>hn', function()
  if vim.wo.diff then
    vim.api.nvim_exec('normal ]c', false)
  else
    gitsigns.next_hunk()
 end
end
}, 'next-hunk')

nnoremap({ '<leader>hp', function()
  if vim.wo.diff then
    vim.api.nvim_exec('normal [c', false)
  else
    gitsigns.prev_hunk()
  end
end
},'prev-hunk')

onoremap({ 'ih', function() gitsigns.select_hunk() end })
xnoremap({ 'ih', function() gitsigns.select_hunk() end })

-- Fern
nnoremap({ '<leader>o', ':Fern . -reveal=%<cr>' }, 'reveal-file')

-- Easy Align
vmap({ '<cr>', '<Plug>(EasyAlign)' }, 'easy-align-selected')
nmap({ 'ga', '<Plug>(EasyAlign)' }, 'easy-align')

-- Emmet
imap({ ',,', '<c-y>,'})

-- Projectionist
nnoremap({ '<leader>rc', ':Econtroller<cr>'}, 'goto-controller')
nnoremap({ '<leader>rm', ':Emodel<cr>'}, 'goto-model')
nnoremap({ '<leader>rv', ':Eview<cr>'}, 'goto-view')
nnoremap({ '<leader>ra', ':A<cr>'}, 'alternate-file')
nnoremap({ '<leader>rr', ':R<cr>'}, 'related-file')

-- Test
nnoremap({ '<leader>tn', ':TestNearest<cr>'}, 'test-nearest')
nnoremap({ '<leader>tf', ':TestFile<cr>'}, 'test-file')
nnoremap({ '<leader>tl', ':TestLast<cr>'}, 'test-last')
nnoremap({ '<leader>tv', ':TestVisit<cr>'}, 'test-visit')

-- ALE
nmap({ '<leader>q', '<Plug>(ale_fix)' }, 'ale-fix')
-- nmap({ '<c-k>', '<Plug>(ale_next_wrap)' }, 'ale-next-error')
-- nmap({ '<c-j>', '<Plug>(ale_prev_wrap)' }, 'ale-prev_error')


nnoremap({'gp', require('goto-preview').goto_preview_definition})
nnoremap({'gP', require('goto-preview').close_all_win})
-- nnoremap({ '<tab>' , function() require'hop'.hint_words() end })

-- Asterisk
nmap({ '*', '<Plug>(asterisk-*)' })
nmap({ '#', '<Plug>(asterisk-#)' })
nmap({ 'g*', '<Plug>(asterisk-g*)' })
nmap({ 'g#', '<Plug>(asterisk-g#)' })
nmap({ 'z*', '<Plug>(asterisk-z*)' })
nmap({ 'gz*', '<Plug>(asterisk-gz*)' })
nmap({ 'z#', '<Plug>(asterisk-z#)' })
nmap({ 'gz#', '<Plug>(asterisk-gz#)' })

-- Reload chrome
nnoremap({ '<leader>cr', ':w<cr>:call system("chrome-cli reload")' }, 'reload-chrome')
nnoremap({ '<leader><leader>', ':luafile %<cr>' }, 'reload-lua-file')

-- Allow line split using S, as opposed to J(oin)
nnoremap({ 'K',  'i<cr><Esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>' }, 'split-line')

-- Compe auxiallary bindings
inoremap({ '<c-space>', 'compe#complete()', expr = true})
inoremap({ '<c-e>', 'compe#close("<c-r>")', expr = true })

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>LspTroubleToggle<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>LspTroubleToggle lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>LspTroubleToggle lsp_document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>LspTroubleToggle loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>LspTroubleToggle quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>LspTrouble lsp_references<cr>", {silent = true, noremap = true})


-- require("fzf").default_window_options = {
--   window_on_create = function(win)
--     -- vim.cmd("set winhl=Comment:Comment")
--     -- print(vim.inspect(window))

--     -- vim.api.nvim_win_set_option()
--     -- Make sure it exits properly
--     vim.cmd("hi TestHighlight guibg=#efefef")
--     -- vim.api.nvim_win_set_option(win, 'winhl', 'Normal:TestHighlight')
--     vim.cmd("set winhl=Normal:Normal")
--     vim.cmd("set winhl=FloatBorder:TestHighlight")
--     -- vim.api.nvim_win_set_option(win, 'winhl', 'FloatBorder:TestHighlight')

--     vim.cmd("inoremap <buffer><silent> <esc> <C-o>:close<cr>")
--     vim.cmd([[
--       augroup FzfEnsureClose
--         autocmd!
--         autocmd WinLeave * ++once close
--       augroup end
--       ]])
--   end,
--   width = vim.o.columns,
--   border = "solid",
--   -- border = "shadow",
--   -- border = "double",
--   -- relative = "bottom",
--   height = 13,
-- }

-- nnoremap({ 'gk', '' })
-- nnoremap({ 'K',  })

-- I'm not using (And have no intention of starting to use) marks, harpoon is
-- better, and I would use a leader key for this anyway
nnoremap({ 'm', '<nop>' })

-- I'm not using this, and I want a free key
nnoremap({ 't', '<nop>' })

-- `cl` is a synonym
-- nnoremap({ 's', '<nop>' })

-- Nearly same as <cr>
nnoremap({ '_', '<nop>' })

-- Begone
nnoremap({ 'Q', '<nop>' })

local function get_current_char()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  return vim.api.nvim_get_current_line():sub(col, col)
end

local function change_surrounding_matches()
  return vim.fn.feedkeys("cs" .. get_current_char())
end

local function delete_surrounding_matches()
  return vim.fn.feedkeys("ds" .. get_current_char())
end

nnoremap({ "<leader>ds", require'dap'.stop }, "dap-stop")
nnoremap({ "<leader>dc", require'dap'.continue }, "dap-continue")
nnoremap({ "<leader>dk", require'dap'.up }, "dap-up")
nnoremap({ "<leader>dj", require'dap'.down }, "dap-down")
nnoremap({ "<leader>dt", require'dap'.toggle_breakpoint }, "dap-toggle-breakpoint")
nnoremap({ "<leader>d-", require'dap'.run_last }, "dap-last")
nnoremap({ "<leader>dr", function() require'dap'.repl.open({}, 'vsplit') end }, "dap-repl")
nnoremap({ "<leader>di", require'dap.ui.variables'.hover }, "dap-repl")
vnoremap({ "<leader>di", require'dap.ui.variables'.visual_hover }, "dap-repl")
nnoremap({ "<leader>d?", require'dap.ui.variables'.scopes }, "dap-scopes")
nnoremap({ "<leader>de", function() require'dap'.set_exception_breakpoints({"all"}) end }, "dap-scopes")
-- nnoremap({ "<leader>da", require'debugHelper'.attach }, "dap-attach")
-- nnoremap({ "<leader>dA", require'debugHelper'.attachToRemote }, "dap-attach-remote")
nnoremap({ "<leader>di", require'dap.ui.widgets'.hover }, "dap-hover")

nnoremap { "ds%", delete_surrounding_matches }
nnoremap { "cs%", change_surrounding_matches }

-- local snap = require'snap'
-- snap.maps {
--   {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
--   {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
--   {"<Leader>ff", snap.config.vimgrep {}},
-- }

-- nnoremap({ '<leader>ab', function()
--   snap.run {
--     producer = snap.get'consumer.fzf'(snap.get'producer.ripgrep.file'),
--     select = snap.get'select.file'.select,
--     multiselect = snap.get'select.file'.multiselect,
--     views = {snap.get'preview.file'}
--   }
-- end})

nnoremap({ "<C-j>", ":resize +2<cr>" })
nnoremap({ "<C-k>", ":resize -2<cr>" })
nnoremap({ "<C-n>", "<C-w>w" })
-- nnoremap({ "<leader><leader>", "<c-w>m" })

vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})

wk.register(wk_dict)
