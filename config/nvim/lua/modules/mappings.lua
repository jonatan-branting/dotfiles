local autocmd = require("modules.autocmd")
local utils = require("utils")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local call = function(mode, key, action)
  local executable_action = nil

  if type(action) == "string" then
    executable_action = function()
      vim.api.nvim_feedkeys(t(action), mode, true)
    end
  elseif type(action) == "function" then
    executable_action = action
  end

  return function()
    executable_action()
    autocmd.emit("MappingExecuted", mode, key, executable_action)
  end
end

-- local keymap = {
--   set = function(...)
--     local mode, keymap, action = unpack({...})

--     vim.keymap.set(mode, keymap, call(mode, keymap, action))
--   end
-- }
local keymap = vim.keymap

local function nnoremap(opts, desc)
  return keymap.set("n", unpack(opts or {}))
end

local function inoremap(opts, desc)
  return keymap.set("i", unpack(opts or {}))
end

local function tnoremap(opts, desc)
  return keymap.set("t", unpack(opts or {}))
end

local function onoremap(opts, desc)
  return keymap.set("o", unpack(opts or {}))
end

local function xnoremap(opts, desc)
  return keymap.set("s", unpack(opts or {}))
end

local function snoremap(opts, desc)
  return keymap.set("s", unpack(opts or {}))
end

local function cnoremap(opts, desc)
  return keymap.set("c", unpack(opts or {}))
end

local function vnoremap(opts, desc)
  return keymap.set("x", unpack(opts or {}))
end

-- Convenience <leader> mappings
nnoremap({ '<leader>s', ':w<cr>' }, 'save-file')
-- nnoremap({ '<leader>x', ':x<cr>' }, 'save-and-exit')

-- General opinionated behaviour changes
-- Make Enter open a line in normal mode, above or below, respectively
-- nnoremap({ '<c-cr>', 'o<esc>' }, 'open-line-below')
-- nnoremap({ '<s-cr>', 'O<esc>' }, 'open-line-above')

inoremap({ 'jj', '<esc>' }, 'escape')
snoremap({ 'jj', '<esc>' })
cnoremap({ 'jj', '<esc>' }, 'escape')
tnoremap({ 'jj', '<c-\\><c-n>' }, 'escape')

vim.api.nvim_set_keymap('n', 'k', "(v:count == 0 ? 'gk' : 'k')", {silent = true, expr = true})
vim.api.nvim_set_keymap('n', 'j', "(v:count == 0 ? 'gj' : 'j')", {silent = true, expr = true})
vim.api.nvim_set_keymap('v', 'k', "(v:count == 0 ? 'gk' : 'k')", {silent = true, expr = true})
vim.api.nvim_set_keymap('v', 'j', "(v:count == 0 ? 'gj' : 'j')", {silent = true, expr = true})

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
      return vim.cmd [[normal $h]]
    else
      return vim.cmd [[normal g$h]]
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


-- TODO g0 first, then the other behaviour!
vim.api.nvim_set_keymap('n', 'H', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})
vim.api.nvim_set_keymap('v', 'H', "getline('.')[0 : col('.') - 2] =~# '^\\s\\+$' ? '0' : '^'", {silent = true, noremap = true, expr = true})

vim.api.nvim_set_keymap('v', '<', '<gv', {silent = true, noremap = true, nowait = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {silent = true, noremap = true, nowait = true})

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

-- Reload easily
nnoremap({ '<leader>R', ':Reload<cr>' })

-- Windows
-- TODO better window management
-- maybe a hydra?

nnoremap({ '<leader>ww', '<c-w>w' }, '?')
nnoremap({ '<leader>wd', '<c-w>c' }, 'delete-window')
nnoremap({ '-', '<c-w>-'})
nnoremap({ '+', '<c-w>+'})

nnoremap({ 'yc', '<c-w>c' }, 'delete-window')
nnoremap({ 'yd', '<c-w>j' }, 'delete-window')
nnoremap({ 'yu', '<c-w>k' }, 'delete-window')

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

-- local fzf = require("fzf-lua")
-- nnoremap({ '<leader><leader>', fzf.files }, 'find-files')
-- nnoremap({ '<leader>f', fzf.live_grep_native }, 'live-grep')
-- nnoremap({ '<leader>e', fzf.buffers }, 'list-buffers')
-- nnoremap({ '<leader>m', fzf.oldfiles }, 'most-recent')
-- nnoremap { "<leader>l", fzf.resume }
-- nnoremap { "gw", fzf.grep_cword }
-- nnoremap { "gW", fzf.grep_cWORD }

-- vnoremap { "gw", fzf.grep_visual }

local telescope = require("telescope.builtin")
nnoremap({ '<leader><leader>', function() telescope.find_files({ hidden = true }) end }, 'find-files')
nnoremap({ '<leader>f', function() telescope.live_grep({hidden =true}) end }, 'live-grep')
nnoremap({ '<leader>F', function() telescope.grep_string({hidden = true, grep_open_files = true}) end }, 'live-grep')
nnoremap({ '<leader>e', telescope.buffers }, 'list-buffers')
nnoremap({ '<leader>m', telescope.oldfiles }, 'most-recent')
nnoremap { "<leader>l", telescope.resume }
nnoremap { "<leader>c", telescope.command_history }
nnoremap { "gw", function() telescope.grep_string() end }

-- If this is not an Ex command Telescope will require me to press <esc> to see the results for no apparentreason
vnoremap ({ 'gw',
  function()
    local search = ":Rg " .. require"utils".get_visual_selection()

    vim.cmd(search)
    vim.api.nvim_input("<esc>")
  end
}, 'grep-selected')

nnoremap ({
  '<leader>i',
  function()
    telescope.find_files({hidden = true, search_dirs = { vim.fn.expand('%:h') }})
  end,
}, 'files-in-folder')

vnoremap({ '*',
  function()
    local search = require"utils".get_visual_selection()

    vim.api.nvim_input([[<esc>]])
    vim.api.nvim_input("/" .. search .. "<cr>")
  end
}, 'visual-star')

-- Neoterm
nnoremap({ "<leader><tab>", ":tabnext<cr>"})

-- Git
nnoremap({ '<leader>gc', ':PopupNext Git commit<cr>' }, 'git-commit')
nnoremap({ '<leader>gl', ':PopupNext Git log --name-only<cr>' }, 'git-log')
nnoremap({ '<leader>gf', ':PopupNext Git log --name-only --invert-grep --grep="^fixup!" --pretty="format:%h %Cf"<cr>' }, 'git-log')
nnoremap({ '<leader>gs', ':PopupNext Git<cr>' }, 'git-status')
nnoremap({ '<leader>gg', ':PopupNext Git status<cr>' }, 'neogit')
nnoremap({ '<leader>ga', ':Git add %<cr>' }, 'git-add-%')
nnoremap({ '<leader>gd', ':Gdiffsplit master<cr>' }, 'git-diff-split')
nnoremap({ '<leader>gm', ':Git mergetool<cr>' }, 'git-mergetool')
vim.keymap.set("n", "<leader>gw", require("telescope").extensions.git_worktree.git_worktrees, {})


-- GitSigns
local gitsigns =  require('gitsigns')
nnoremap({ '<leader>hs', function() gitsigns.stage_hunk() end }, 'stage-hunk')
nnoremap({ '<leader>hu', function() gitsigns.undo_stage_hunk() end }, 'undo-hunk')
nnoremap({ '<leader>hr', function() gitsigns.reset_hunk() end }, 'reset-hunk')
nnoremap({ '<leader>hR', function() gitsigns.reset_buffer() end }, 'reset-buffer')
nnoremap({ '<leader>hb', function() gitsigns.blame_line() end}, 'blame-line')

nnoremap({ ']h', function()
    if vim.wo.diff then
      vim.api.nvim_exec('normal ]c', false)
    else
      gitsigns.next_hunk()
    end
  end
}, 'next-hunk')

nnoremap({ '<leader>hn', function()
  if vim.wo.diff then
    vim.api.nvim_exec('normal ]c', false)
  else
    gitsigns.next_hunk()
 end
end
}, 'next-hunk')

nnoremap({ '[h', function()
    if vim.wo.diff then
      vim.api.nvim_exec('normal [c', false)
    else
      gitsigns.prev_hunk()
    end
  end
},'prev-hunk')

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
vnoremap({ '<cr>', '<Plug>(EasyAlign)' }, 'easy-align-selected')
nnoremap({ 'ga', '<Plug>(EasyAlign)' }, 'easy-align')

-- Emmet
inoremap({ ',,', '<c-y>,'})

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

nnoremap({"gp", "p"})

-- Asterisk
nnoremap({ '*', '<Plug>(asterisk-*)' })
nnoremap({ '#', '<Plug>(asterisk-#)' })
nnoremap({ 'g*', '<Plug>(asterisk-g*)' })
nnoremap({ 'g#', '<Plug>(asterisk-g#)' })
nnoremap({ 'z*', '<Plug>(asterisk-z*)' })
nnoremap({ 'gz*', '<Plug>(asterisk-gz*)' })
nnoremap({ 'z#', '<Plug>(asterisk-z#)' })
nnoremap({ 'gz#', '<Plug>(asterisk-gz#)' })

-- Allow line split using S, as opposed to J(oin)
-- nnoremap({ 'S',  'i<cr><Esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>' }, 'split-line')

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
nnoremap({ "<leader>de", function() require'dap'.set_exception_breakpoints({"all"}) end }, "dap-scopes")

local todo = require("modules._todo")

nnoremap({ "<leader>z", todo.open_branch_todo }, "open-branch-todo")

nnoremap({"<c-k>", ":m .-2<CR>=="})
nnoremap({"<c-j>", ":m .+1<CR>=="})
vnoremap({"<c-k>", ":m '<-2<CR>gv=gv"})
vnoremap({"<c-j>", ":m '>+1<CR>gv=gv"})

vnoremap({"<up>", ":m '<-2<CR>gv=gv"})
vnoremap({"<down>", ":m '>+1<CR>gv=gv"})
vnoremap({"<left>", "<gv"})
vnoremap({"<right>", ">gv"})

nnoremap({ "<down>", "<c-w>j" })
nnoremap({ "<up>", "<c-w>k" })
nnoremap({ "<left>", "<c-w>h" })
nnoremap({ "<right>", "<c-w>l" })

nnoremap({ "<s-down>",  require'smart-splits'.resize_down })
nnoremap({ "<s-up>",  require'smart-splits'.resize_up })
nnoremap({ "<s-left>",  require'smart-splits'.resize_left })
nnoremap({ "<s-right>",  require'smart-splits'.resize_right })

nnoremap({ "<c-a>", "0" })
nnoremap({ "<c-e>", "$" })

-- nnoremap({ "<C-n>", "<C-w>w" })

-- vim.api.nvim_set_keymap('x', 'in', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('x', 'an', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('o', 'in', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
-- vim.api.nvim_set_keymap('o', 'an', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})

nnoremap({ "<leader>a", "<c-^>" }, "alternate-last-buffer")

nnoremap({"<leader>,", ":Tfocus<cr>"}, "toggle-term")
tnoremap({"<c-o>", "<c-\\><c-n><c-o>"})

-- Register keybindings for usage with better-n

inoremap { ";;", "<esc>A;<esc>" }
inoremap { ",,", "<esc>A,<esc>" }

vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

nnoremap { "gd", "gf" }

require('refactoring').setup({
  formatting = {
    lua = {
      cmd = "echom test!"
    }
  }
})
vim.keymap.set("v", "<leader>r",
  function()
    vim.api.nvim_feedkeys(utils.t("<esc>"), "v", false)
    require('refactoring').select_refactor()
  end,
  {}
)

vim.keymap.set({ "n", "x" }, "xi", function ()
  vim.api.nvim_feedkeys(utils.t("<esc>"), "v", false)
  require('refactoring').refactor('Inline Variable')
end, {silent = true})

vim.keymap.set("x", "xv", function ()
  vim.api.nvim_feedkeys(utils.t("<esc>"), "v", false)
  require('refactoring').refactor('Extract Variable')
end, {silent = true})

local function extract_function_callback()
  -- local selection = utils.get_selection(false)
  -- vim.fn.setpos()
  -- vim.api.nvim_feedkeys(utils.t("<esc>"), "v", false)
  require('refactoring').refactor('Extract Function')
end

vim.keymap.set("n", "xf", function()
  vim.go.operatorfunc = "v:lua.require'modules.mappings'.extract_function_callback"

  return "g@"
end, {expr = true})


vim.keymap.set("x", "xf", function ()
  vim.api.nvim_feedkeys(utils.t("<esc>"), "v", false)

  vim.schedule(function()
    require('refactoring').refactor('Extract Function')
  end)
end, {silent = true})

require("syntax-tree-surfer").setup({})
-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
vim.keymap.set("n", "gK", function()
  return "g@l"
end, { silent = true, expr = true })

vim.keymap.set("n", "gJ", function()
  vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
  return "g@l"
end, { silent = true, expr = true })

vim.keymap.set("n", "x>", function()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
  return "g@l"
end, { silent = true, expr = true })
vim.keymap.set("n", "x<", function()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
  return "g@l"
end, { silent = true, expr = true })

require("leap").setup({
  {
    repeat_search = '<enter>',
    next_group    = '<space>',
    prev_group    = '<tab>',
    eol           = '<space>',
    next_match = "n",
    prev_match = "<s-n>"
  }
})
vim.keymap.set({"n", "x"}, "q", "<Plug>(leap-forward)")
vim.keymap.set({"n", "x"}, "Q", "<Plug>(leap-backward)")
vim.keymap.set({"x", "o"}, "q", require("leap-ast").leap)

-- Usage:
local leap_multi = require("modules.leap_multi")
-- vim.keymap.set("n", "<c-n>", function()
--   vim.cmd("*")
-- end)

local ts_utils = require("nvim-treesitter.ts_utils")
vim.keymap.set("o", "r", function()
  require("leap").leap({
    -- targets =  TODO after first character, get all ts nodes and filter them, then show labels for each one jump to that target and run the current operator on the node!
    -- qurstions: keep cursor there? only for change maybe, a bit inconsistent though... Maybe jump back for change too once done? That'd be weird though
    action = function(target)
      -- print(vim.inspect(target))
    end,
  })
end)

cnoremap({"<c-x>", "<c-v><esc>"})
vnoremap({"<tab>", "\"zc"})

vim.keymap.set({"x", "n"}, "gh", "^", {})
vim.keymap.set({"x", "n"}, "gl", "$", {})

local leap_ast = require("modules.leap_ast")

-- vim.schedule(function()
--   vim.keymap.set("n", "c", function()
--     require("leap").last_input = nil

--     require("leap").leap({
--       target_windows = {vim.fn.win_getid()},
--       operator = "c",
--       did_jump = false,
--       no_autojump = true,
--       action = leap_ast.action,
--       labels = {"o", "d", "r", "q", "y", "x", "e", "v", "g", "u", ".", "z", "/", "F", "L", "N", "H", "G", "M", "U", "T", "?", "Z"},
--       targets = leap_ast.targets(),
--     }
--   end, { nowait = true, desc = "ast" })
-- end)

local dynamic_textobj_active = false
local last_operator = nil
local is_in_cmdline = false

vim.api.nvim_create_autocmd("User",
  {
    pattern = "TreehopperLeave",
    callback = function (args)
      if not dynamic_textobj_active then return end

      -- print('dynamic_textobj_active', dynamic_textobj_active)
      -- print('last_operator', last_operator)
      -- print('is_in_cmdline', is_in_cmdline)

      if args.data.jumped then
        vim.schedule(function() dynamic_textobj_active = false end)

        return
      end

      local motion = args.data.key
      -- print("args", vim.inspect(args.data))
      -- print("motion", motion)

      if motion and not args.data.jumped then
        vim.api.nvim_input(utils.t("<esc>" .. last_operator .. motion))
      else
        vim.api.nvim_feedkeys(utils.t("<esc>"), "n", false)
      end

      vim.schedule(function() dynamic_textobj_active = false
      end)
    end
  }
)

local function _t()
  vim.api.nvim_feedkeys(utils.t(last_operator), "n", false)
end

require("tsht").config.hint_keys = {"q", "x", "e", "v", "g", "u", ".", "z", "/", "G", "M", "U", "?", "Z"}
-- let's test this out, might work, might not work, seems kinda promising but
-- we'll see :)
-- vim.api.nvim_create_autocmd("ModeChanged",
--   {
--     pattern = "n:no",
--     callback = function(args)
--       -- schedule and check mode to ignore this in certain cases where the mode
--       -- is instantly changed back, which caused flickering beacons
--       vim.schedule(function()
--         if vim.api.nvim_get_mode()["mode"] ~= "no" then return end
--         if dynamic_textobj_active then return end
--         if is_in_cmdline then return end

--         dynamic_textobj_active = true
--         last_operator = vim.v.operator

--         local success = pcall(require('tsht').nodes)
--         if not success then
--           dynamic_textobj_active = false
--         end
--       end)
--     end
--   }
-- )

vim.api.nvim_create_autocmd("CmdlineEnter", { callback = function () is_in_cmdline = true end })
vim.api.nvim_create_autocmd("CmdlineLeave", { callback = function () is_in_cmdline = false end })

vim.keymap.set("x", "p", "\"_dP")

-- nowait only works if the mapping is defined last of all contesting bindings
vim.schedule(function()
  -- vim.keymap.set("n", "c", "c", {nowait = true})
  -- vim.keymap.set("n", "d", "d", {nowait = true})
  -- vim.keymap.set("n", "y", "y", {nowait = true})
  vim.cmd("normal! qtq")
end)

vim.keymap.set("n", "x", "<nop>")

vim.keymap.set("n", "se", function()
  require("modules.selection").norm_on_selection()
end)
-- vim.keymap.set("n", "su", function()
--   require("modules.select_mode").remove_last_cursor()
-- end)
vim.keymap.set("n", "sq", function()
  require("modules.selection").clear_selection()
end)

-- vim.key.map.set("v", "s", function()
--   require("modules.select_mode").select
-- end)

-- TODO make dot repeatable...
-- TODO make :Norm use select-mode to get the targets? nah
vim.keymap.set("n", "mm", function()
  local row = vim.fn.line(".")
  local col = vim.fn.col(".")
  -- TODO select entire range
  -- require("modules.select_mode").select_range()
end)

--TODO ss in visual mode, support for blockwise, linewise and charwise
-- linewise is beginning of each line
-- blockwise is beginning of each selection (like c-v I)
-- charwise is ??

vim.g.last_mode_change = nil
vim.api.nvim_create_autocmd("ModeChanged", {
  callback = function(args)
    if args.match == "n:c" then return end
    -- print(args.match)
    vim.g.last_mode_change = args.match
  end
})

vim.keymap.set("o", "o", require("modules.occurrence_modifier").motion)
vim.keymap.set("o", "m", require("modules.selection").motion)
vim.keymap.set({"n", "x"}, "m", function()
  vim.go.operatorfunc = "v:lua.require'modules.selection'.opfunc"

  return "g@"
end, {expr = true})

vim.keymap.set({"o"}, "o", function()
  return require("modules.occurrence_modifier").motion()
end)

vim.api.nvim_create_user_command("M",
  function(args)
    local line = args.line1
    local contents = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    require("modules.selection").select_range(line, 0, line, #contents - 1)
  end
, { range = true })

vim.keymap.set("n", "<c-h>",
  function()
    local cword = vim.fn.expand("<cword>")
    vim.cmd("help " .. cword)
  end
, {})

vim.keymap.set("n", "mx", function() require("modules.selection").motion({preselect = false, operator = "a", reverse = true}) end)
vim.keymap.set("n", "mz", function() require("modules.selection").motion({preselect = false, operator = "i"}) end)
-- vim.keymap.set("n", "g.", "'.")
-- vim.keymap.set("n", "[m", "g;")
-- vim.keymap.set("n", "]m", "g,")
vim.keymap.set("n", "<leader>p", "")

vim.api.nvim_create_user_command("AutorunCurrentFile",
  function()
    require("modules.autorun").current_lua_file()
  end,
  {}
)

vim.api.nvim_create_user_command("Autorun",
  function()
    require("modules.autorun").current_lua_file()
  end,
  {}
)

-- nnoremap({"n", "gp", "p"})
-- nnoremap({"n", "p", "["})
-- nnoremap({"n", "p", "["})

vim.keymap.set({"n", "x"}, "<s-n>", require("better-n").shift_n, { nowait = true })
vim.keymap.set({"n", "x"}, "n", require("better-n").n, { nowait = true })

local function test()
  
end
-- slurp
local ts_extras = require("treesitter_extras")
vim.inspect(test(123), test(123))


vim.inspect()test(234)

local function get_outermost_node(node)
  local srow, scol, erow, ecol = node:range()
  while true do
    local parent = node:parent()
    local psrow, pscol, _, _ = parent:range()
    if psrow == srow and pscol == scol then
      node = parent
    else
      goto br
    end
  end
  ::br::
  return node
end

vim.keymap.set({"i"}, "<c-n>",
  function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local node = get_outermost_node(ts_extras.get_node_at_position(0, true, row - 1, col + 1)) -- # get next node instead, might be whitespace or a comma or something

    local line_str = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]
    local node_str = vim.treesitter.get_node_text(node, 0)

    local cursor_node = ts_extras.get_node_at_position(0, true, row - 1, col)
    local has_children = cursor_node:named_child_count() > 0
    local srow, scol, erow, ecol = cursor_node:range()

    -- print("cursor_node", vim.treesitter.get_node_text(cursor_node, 0))
    -- print("node", vim.treesitter.get_node_text(node, 0))
    local res
    if has_children then
      res = string.sub(line_str, 0, ecol - 1) .. ", " .. node_str .. string.sub(line_str, ecol + #node_str, #line_str)
    else
      res = string.sub(line_str, 0, ecol - 1) .. node_str .. string.sub(line_str, ecol + #node_str, #line_str)
    end
    vim.api.nvim_buf_set_lines(0, row -1, row, true, {res})

    -- vim.inspect(test())vim.inspect(test(234))

    -- vim.inspect()test(234)

    vim.schedule(function()
        cursor_node = ts_extras.get_node_at_position(0, true, row - 1, col)
        srow, _, _, ecol = cursor_node:range()
        vim.api.nvim_win_set_cursor(0, {srow + 1, ecol -1})
    end)
  end,
  {}
)

-- TODO fix this..
-- vim.keymap.set("n", "<c-n>", function ()
--   local str = select.get_current_buffer():get_last_selection():get_text()
--   vim.cmd("/" .. str)
--   vim.api.nvim_feedkeys(utils.t("mgn"), "n", false)
-- end)

vim.keymap.set({"n", "o", "x"}, "<c-w>", "w")

-- local select_mode = require("modules.select-mode")
-- local selectors = require("modules.select-mode.selectors")
--   -- setup_select_move("d", word_select()) -- support for opfuncs?
--   -- TODO allow passing string? 
--   -- select() is rather get_selector()
-- select_mode.setup_select_move("w", selectors.word.select()) -- allow "override" with keys other than .. key as final action
-- select_mode.setup_select_move("b", selectors.word.select())
-- select_mode.setup_select_move("e", selectors.word.select({ start_inclusive = true, end_inclusive = false }))
-- select_mode.setup_select_move("h", selectors.char.select()) -- only clear
-- select_mode.setup_select_move("j", selectors.char.select())
-- select_mode.setup_select_move("k", selectors.char.select())
-- select_mode.setup_select_move("l", selectors.char.select()) -- only clear

-- select_mode.setup_select_move("}", selectors.range.select({linewise = true}))
-- select_mode.setup_select_move("{", selectors.range.select({linewise = true}))

-- select_mode.setup_select_move("}", selectors.range.select({linewise = true}))
-- select_mode.setup_select_move("{", selectors.range.select({linewise = true}))

-- -- how do i make this play well with better-n? direct integration i think...
-- select_mode.setup_select_move("f", selectors.range.select())
-- select_mode.setup_select_move("F", selectors.range.select())
-- select_mode.setup_select_move("t", selectors.range.select())
-- select_mode.setup_select_move("T", selectors.range.select())
-- -- clear.select should also be a thing! for example for o
-- -- } etc line sele


-- vim.keymap.set("n", "dd", "<nop>")

-- local selection = require("modules.selection")
-- local select_mode = require("modules.select-mode")
-- vim.schedule(function()
--   -- TODO actual change/delete functions as opposed to trying to it
--   -- generically. running operators generically on selections work fine as long
--   -- as they do not enter insert mode...
--   vim.keymap.set("n", "d", function()
--     select_mode.execute_operator("d", {
--       preselect = true,
--       autoconfirm = true,
--     })
--     -- use latest selector afterwards?
--   end, { nowait=true })

--   vim.keymap.set("n", "c", function()
--     select_mode.execute_operator("c", {
--       preselect = true,
--       autoconfirm = true,
--     })
--     vim.cmd.startinsert()
--   end, { nowait=true })

-- --   vim.keymap.set("n", "a", function()
-- --     -- TODO add selection:gotostart/end
-- --     selection.execute_operator("a", {
-- --       preselect = true,
-- --       autoconfirm = true,
-- --       reverse = true
-- --     })
-- --     vim.cmd.startinsert()
-- --   end, { nowait=true })

-- --   vim.keymap.set("n", "i", function()
-- --     selection.execute_operator("i", {
-- --       preselect = false,
-- --       autoconfirm = true,
-- --     })
-- --     vim.cmd.startinsert()
-- --   end, { nowait=true })


--   -- this is a type of select (line select)
--   -- should increment downwards...
--   vim.keymap.set("n", "x", function()
--     selection.clear_selection()
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--     print({ row, 1, row, - 1 })
--     selection.select_range({ row, 1, row, - 1 })
--   end, { nowait=true })

--   vim.keymap.set("n", "mm", function()
--     selection.clear_selection()
--     local row, col = unpack(vim.api.nvim_win_get_cursor(0))
--     print({ row, 1, row, - 1 })
--     selection.select_range({ row, 1, row, - 1 })
--   end, { nowait=true })
-- end)
-- vim.keymap.set("n", "w", function ()
--   -- todo way to mark occurrence under cursor, could be word, function, 
--   -- vim.api.nvim_feedkeys(utils.t("miw"), "n", false)
-- end)

return {
  extract_function_callback = extract_function_callback,
  _t = _t
}

