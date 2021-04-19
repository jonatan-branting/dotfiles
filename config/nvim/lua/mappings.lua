local keymap = require('astronauta.keymap')
local cnoremap = keymap.cnoremap
local vmap = keymap.vmap
local onoremap = keymap.onoremap
local xnoremap = keymap.xnoremap
local nmap = keymap.nmap
local imap = keymap.imap
local tnoremap = keymap.tnoremap

-- TODO: use these description for some which-key style display :)
local function nnoremap(opts, desc)
  local mapping = opts[1]
  return keymap.nnoremap(opts)
end

local function inoremap(opts, desc)
  local mapping = opts[1]
  return keymap.inoremap(opts)
end

local function vnoremap(opts, desc)
  local mapping = opts[1]
  return keymap.vnoremap(opts)
end

-- Convenience <leader> mappings
nnoremap({ '<leader>s', ':w<cr>' }, 'save-file')
nnoremap({ '<leader>x', ':x<cr>' }, 'save-and-exit')

-- General opinionated behaviour changes
-- Make Enter open a line in normal mode, above or below, respectively
nnoremap({ '<cr>', 'o<esc>' }, 'open-line-below')
nnoremap({ '<s-cr>', 'O<esc>' }, 'open-line-above')

inoremap({ 'jj', '<esc>' }, 'escape')
cnoremap({ 'jj', '<esc>' }, 'escape')
tnoremap({ 'jj', '<c-\\><c-n>' }, 'escape')

nnoremap({ '<silent><expr> k', "(v:count == 0 ? 'gk' : 'k')" })
nnoremap({ '<silent><expr> j', "(v:count == 0 ? 'gj' : 'j')" })
vnoremap({ '<silent><expr> k', "(v:count == 0 ? 'gk' : 'k')" })
vnoremap({ '<silent><expr> j', "(v:count == 0 ? 'gj' : 'j')" })
nnoremap({ 'L', 'g$' })
nnoremap({ 'H', 'g^' })
vnoremap({ 'L', 'g$' })
vnoremap({ 'H', 'g^' })
vnoremap({ '>', '>gv' })
vnoremap({ '<', '<gv' })

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
tnoremap({ '<esc>', '<c-\\><c-n>' })

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
nnoremap({ '<leader>=', '<c-w>=' }, 'balance-windows')

-- Buffers
nnoremap({ '<leader>bd', ':bd<cr>' }, 'delete-buffer')
nnoremap({ '<leader>bh', ':Startify<cr>' }, 'start-screen/home')
nnoremap({ '<leader>bn', ':bnext' }, 'next-buffer')
nnoremap({ '<leader>bp', ':bprev' }, 'prev-buffer')

-- LSP (TODO: only attach these when necessary)
nnoremap({ 'gD', function() vim.lsp.buf.declaration() end }, 'goto-declaration')
nnoremap({ 'gd', function() vim.lsp.buf.definition() end }, 'goto-definition')
nnoremap({ 'K', function() vim.lsp.buf.hover() end }, 'show-documentation')
nnoremap({ 'gi', function() vim.lsp.buf.implementation() end }, 'goto-implementation')
nnoremap({ '<c-k>', function() vim.lsp.buf.signature_help() end }, 'signature-help')
nnoremap({ '<leader>D', function() vim.lsp.buf.type_definition() end }, 'type-definition')
nnoremap({ 'gr', function() vim.lsp.buf.references() end }, 'find-references')
nnoremap({ '<leader>ar', function() vim.lsp.buf.rename() end }, 'rename-under-cursor')
nnoremap({ '<leader>af', function() vim.lsp.buf.formatting() end }, 'format')
vnoremap({ '<leader>af', function() vim.lsp.buf.range_formatting() end }, 'format-selected')

-- Telescope
local telescope = require('telescope.builtin')

nnoremap({ '<leader>p', function() telescope.find_files() end }, 'find-files')
nnoremap({ '<leader>f', function() telescope.live_grep() end }, 'grep-string')
nnoremap({ '<leader>e', function() telescope.buffers({ sort_lastused = true, ignore_current_buffer = true }) end }, 'list-buffers')
nnoremap({ '<leader>m', function() require('telescope').extensions.frecency.frecency() end }, 'most-recent')
nnoremap({ 'gw', function() telescope.grep_string({ search = vim.fn.expand('<cword>') }) end }, 'grep-cword')

-- If this is not an Ex command Telescope will require me to press <esc> to see the results for no apparentreason
vnoremap ({ 'gw',
':lua require"telescope.builtin".grep_string({ search = require"utils".get_visual_selection() })<cr>'
}, 'grep-selected')

local get_current_file_dir = function() return vim.fn.expand('%:h') end
nnoremap({ '<leader>i', function() telescope.file_browser({cwd = get_current_file_dir()}) end }, 'files-in-dir')

-- Harpoon
local harpoon_ui = require('harpoon.ui')
local harpoon_term = require('harpoon.term')
local harpoon_mark = require('harpoon.mark')
nnoremap({ '<leader>jh', function() harpoon_mark.add_file() end }, 'harpoon-file')
nnoremap({ '<leader>j1', function() harpoon_ui.nav_file(1) end }, 'goto-harpoon-1')
nnoremap({ '<leader>j2', function() harpoon_ui.nav_file(2) end }, 'goto-harpoon-2')
nnoremap({ '<leader>j3', function() harpoon_ui.nav_file(3) end }, 'goto-harpoon-3')
nnoremap({ '<leader>j4', function() harpoon_ui.nav_file(4) end }, 'goto-harpoon-4')
nnoremap({ '<leader>jt', function() harpoon_term.gotoTerminal(1) end }, 'harpoon-terminal')

-- Git
nnoremap({ '<leader>gc', ':Git commit -m ""<left>' }, 'git-commit')
nnoremap({ '<leader>gl', ':Git log <cr>' }, 'git-log')
nnoremap({ '<leader>gs', ':Git<cr>' }, 'git-status')
nnoremap({ '<leader>gg', ':Neogit<cr>' }, 'neogit')
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

-- UltiSnips (TODO: Remove in favour of vnips? Not sure, as UltiSnips is more powerful)
inoremap({ 'kk', '<c-r>=UltiSnips#ExpandSnippetOrJump()<cr>' })

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
nmap({ '<c-f>', '<Plug>(ale_fix)' }, 'ale-fix')
nmap({ '<c-k>', '<Plug>(ale_next_wrap)' }, 'ale-next-error')
nmap({ '<c-j>', '<Plug>(ale_prev_wrap)' }, 'ale-prev_error')

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

-- Allow line split using S, as opposed to J(oin)
nnoremap({ 'S',  'i<cr><Esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>' }, 'split-line')

-- Compe
inoremap({ '<expr> <c-space>', 'compe#complete()'})
inoremap ({ '<expr> <cr>', function()
  vim.fn.call('compe#confirm({"keys:": "\\<Plug>delimitMateCR"}, "mode": "")')
end})
inoremap({ '<expr> <c-e>', 'compe#close("<c-r>")' })

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
-- move to prev/next item in completion menuone
-- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("UltiSnips#CanExpandSnippet", {1}) == 1 or vim.fn.call("UltiSnips#CanJumpForwards", {1}) == 1 then
    return vim.fn.call("UltiSnips#ExpandSnippetOrJump")
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("UltiSnips#CanJumpBackwards", {1}) == 1 then
    return vim.fn.call("UltiSnips#JumpBackwards")
  else
    return t "<S-Tab>"
  end
end

-- TODO: astronauta this?
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
