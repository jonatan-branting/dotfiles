local keymap = require('astronauta.keymap')
local nnoremap = keymap.nnoremap
local cnoremap = keymap.cnoremap
local inoremap = keymap.inoremap
local vnoremap = keymap.vnoremap
local vmap = keymap.vmap
local onoremap = keymap.onoremap
local xnoremap = keymap.xnoremap
local nmap = keymap.nmap
local imap = keymap.imap
local tnoremap = keymap.tnoremap

-- Convenience <leader> mappings
nnoremap { '<leader>s', ':w<cr>' }
nnoremap { '<leader>x', ':x<cr>' }

-- General opinionated behaviour changes
-- Make Enter open a line in normal mode, above or below, respectively
nnoremap { '<cr>', 'o<esc>' }
nnoremap { '<s-cr>', 'O<esc>' }

inoremap { 'jj', '<esc>' }
cnoremap { 'jj', '<esc>' }
tnoremap { 'jj', '<c-\\><c-n>' }

nnoremap { 'L', 'g$' }
nnoremap { 'H', 'g^' }

vnoremap { '>', '>gv' }
vnoremap { '<', '<gv' }

inoremap { '<c-e>', 'g$' }
inoremap { '<c-a>', 'g0' }

nnoremap { 'X', 'vaw' }

-- Tab navigate pum
inoremap { '<expr> <tab> pumvisible() ? "\\<c-n>" : "\\<tab>"' }
inoremap { '<expr> <s-tab> pumvisible() ? "\\<c-p>" : "\\<c-h>"' }

-- Search and replace selection
vnoremap { '<c-r>', '\"hy:%s/<c-r>h//gc<left><left><left>' }

-- Consistency please!
nnoremap { 'vv', '0v$' }
nnoremap { 'Y', 'y$' }

-- Break undo sequences
inoremap { ',', ',<c-g>u'}
inoremap { '.', '.<c-g>u'}
inoremap { '!', '!<c-g>u'}
inoremap { '?', '?<c-g>u'}

-- Terminal (Non-ANSI layouts make the default keybindings abysmal)
tnoremap { '<esc>', '<c-\\><c-n>' }

-- Windows
nnoremap { '<leader>ww', '<c-w>w' }
nnoremap { '<leader>wd', '<c-w>c' }
nnoremap { '<leader>w-', '<c-w>s' }
nnoremap { '<leader>w/', '<c-w>v' }
nnoremap { '<leader>wh', '<c-w>h' }
nnoremap { '<leader>wj', '<c-w>j' }
nnoremap { '<leader>wk', '<c-w>k' }
nnoremap { '<leader>wl', '<c-w>l' }
nnoremap { '<leader>w<space>', '<c-w>m' }
nnoremap { '<leader>wH', '<c-w>5<' }
nnoremap { '<leader>wL', '<c-w>5>' }
nnoremap { '<leader>wy', '<c-w>H' }
nnoremap { '<leader>=', '<c-w>=' }

-- Buffers
nnoremap { '<leader>bd', ':bd<cr>' }
nnoremap { '<leader>bh', ':Startify<cr>' }
nnoremap { '<leader>bn', ':bnext' }
nnoremap { '<leader>bp', ':bprev' }

-- LSP (TODO: only attach these when necessary)
nnoremap { 'gD', function() vim.lsp.buf.declaration() end }
nnoremap { 'gd', function() vim.lsp.buf.definition() end }
nnoremap { 'K', function() vim.lsp.buf.hover() end }
nnoremap { 'gi', function() vim.lsp.buf.implementation() end }
nnoremap { '<c-k>', function() vim.lsp.buf.signature_help() end }
nnoremap { '<leader>D', function() vim.lsp.buf.type_definition() end }
nnoremap { 'gr', function() vim.lsp.buf.references() end }
nnoremap { 'gr', function() vim.lsp.buf.references() end }
nnoremap { '<leader>ar', function() vim.lsp.buf.rename() end }
nnoremap { '<leader>af', function() vim.lsp.buf.formatting() end }
vnoremap { '<leader>af', function() vim.lsp.buf.range_formatting() end }

-- Telescope
local telescope = require('telescope.builtin')

nnoremap { '<leader>p', function() telescope.find_files() end }
nnoremap { '<leader>f', function() telescope.live_grep() end }
nnoremap { '<leader>e', function() telescope.buffers({ sort_lastused = true, ignore_current_buffer = true }) end }
nnoremap { '<leader>m', function() require('telescope').extensions.frecency.frecency() end }
nnoremap { 'gw', function() telescope.grep_string({ search = vim.fn.expand('<cword>') }) end }

-- If this is not an Ex command Telescope will require me to press <esc> to see the results for no apparent reason
vnoremap { 'gw',
  ':lua require"telescope.builtin".grep_string({ search = require"utils".get_visual_selection() })<cr>'
}

local get_current_file_dir = function() return vim.fn.expand('%:h') end
nnoremap { '<leader>i', function() telescope.file_browser({cwd = get_current_file_dir()}) end }

-- Harpoon
local harpoon_ui = require('harpoon.ui')
local harpoon_term = require('harpoon.term')
local harpoon_mark = require('harpoon.mark')
nnoremap { '<leader>jh', function() harpoon_mark.add_file() end }
nnoremap { '<leader>j1', function() harpoon_ui.nav_file(1) end }
nnoremap { '<leader>j2', function() harpoon_ui.nav_file(2) end }
nnoremap { '<leader>j3', function() harpoon_ui.nav_file(3) end }
nnoremap { '<leader>j4', function() harpoon_ui.nav_file(4) end }
nnoremap { '<leader>jt', function() harpoon_term.gotoTerminal(1) end }

-- Git
nnoremap { '<leader>gc', ':Git commit -m ""<left>' }
nnoremap { '<leader>gl', ':Git log <cr>' }
nnoremap { '<leader>gs', ':Git<cr>' }
nnoremap { '<leader>gg', ':Neogit<cr>' }
nnoremap { '<leader>ga', ':Git add %<cr>' }
nnoremap { '<leader>gd', ':Gdiffsplit master<cr>' }
nnoremap { '<leader>gm', ':Git mergetool<cr>' }

-- GitSigns
local gitsigns =  require('gitsigns')
nnoremap { '<leader>hs', function() gitsigns.stage_hunk() end }
nnoremap { '<leader>hu', function() gitsigns.undo_stage_hunk() end }
nnoremap { '<leader>hr', function() gitsigns.reset_hunk() end }
nnoremap { '<leader>hR', function() gitsigns.reset_buffer() end }
nnoremap { '<leader>hb', function() gitsigns.blame_line() end }

nnoremap { '<leader>hn', function()
  if vim.wo.diff then
    vim.api.nvim_exec('normal ]c', false)
  else
    gitsigns.next_hunk()
  end
end
}
nnoremap { '<leader>hp', function()
  if vim.wo.diff then
    vim.api.nvim_exec('normal [c', false)
  else
    gitsigns.prev_hunk()
  end
end
}

onoremap { 'ih', function() gitsigns.select_hunk() end }
xnoremap { 'ih', function() gitsigns.select_hunk() end }

-- Fern
nnoremap { '<leader>o', ':Fern . -reveal=%<cr>' }

-- Easy Align
vmap { '<cr>', '<Plug>(EasyAlign)' }
nmap { 'ga', '<Plug>(EasyAlign)' }

-- Emmet
imap { ',,', '<c-y>,'}

-- UltiSnips (TODO: Remove in favour of vnips? Not sure, as UltiSnips is more powerful)
inoremap { '<silent> kk', '<c-r>=UltiSnips#ExpandSnippetOrJump()<cr>' }

-- Projectionist
nnoremap { '<leader>rc', ':Econtroller<cr>'}
nnoremap { '<leader>rm', ':Emodel<cr>'}
nnoremap { '<leader>rv', ':Eview<cr>'}
nnoremap { '<leader>ra', ':A<cr>'}
nnoremap { '<leader>rr', ':R<cr>'}

-- Test
nnoremap { '<leader>tn', ':TestNearest<cr>'}
nnoremap { '<leader>tf', ':TestFile<cr>'}
nnoremap { '<leader>tl', ':TestLast<cr>'}
nnoremap { '<leader>tv', ':TestVisit<cr>'}

-- ALE
nmap { '<c-f>', '<Plug>(ale_fix)' }
nmap { '<c-k>', '<Plug>(ale_next_wrap)' }
nmap { '<c-j>', '<Plug>(ale_prev_wrap)' }

-- Asterisk
nnoremap { '*', '<plug>(asterisk-*)' }
nnoremap { '#', '<plug>(asterisk-#)' }
nnoremap { 'g*', '<plug>(asterisk-g*)' }
nnoremap { 'g#', '<plug>(asterisk-g#)' }
nnoremap { 'z*', '<plug>(asterisk-z*)' }
nnoremap { 'gz*', '<plug>(asterisk-gz*)' }
nnoremap { 'z#', '<plug>(asterisk-z#)' }
nnoremap { 'gz#', '<plug>(asterisk-gz#)' }

-- Reload chrome
nnoremap { '<leader>cr', ':w<cr>:call system("chrome-cli reload")' }
