local Hydra = require("hydra")
local gitsigns = require("gitsigns")

local config = {
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      type = "window",
      position = "bottom",
      border = "solid",
      offset = 1
    },
    on_enter = function()
      gitsigns.toggle_linehl(true)
    end,
    on_exit = function()
      gitsigns.toggle_linehl(false)
      gitsigns.toggle_deleted(false)
      vim.cmd 'echo' -- clear the echo area
    end
  },
  mode = {"n","x"},
  body = "<leader>g",
  heads = {
    { "n", function()
      if vim.wo.diff then
        return "]c"
      end

      vim.schedule(function() gitsigns.next_hunk() end)
      return "<Ignore>"
    end, { expr = true } },
    { "p", function()
      if vim.wo.diff then
        return "[c"
      end

      vim.schedule(function() gitsigns.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true } },
    { "s", gitsigns.stage_hunk, desc = "stage hunk" },
    { "r", gitsigns.reset_hunk, desc = "revert hunk" },
    { "U", gitsigns.undo_stage_hunk, desc = "undo stage hunk"},
    { "a", gitsigns.stage_buffer, desc = "stage buffer"},
    { "P", gitsigns.preview_hunk, desc = "preview hunk" },
    { "d", gitsigns.toggle_deleted, { nowait = true }, desc = "show deleted" },
    { "b", gitsigns.blame_line, desc = "blame line"},
    { "l", ':PopupNext Git log --name-only<cr>', desc = "show logs"},
    { "f", ':PopupNext Git log --name-only --invert-grep --grep="^fixup!" --pretty="format:%h %Cf"<cr>', desc = "fixup log"},
    { "B", function() gitsigns.blame_line({ full = true }) end, desc = "blame show full" },
    { "/", gitsigns.show, { exit = true }, desc = "show base file" }, -- show the base of the file
    { "m", ":Git mergetool<cr>", desc = "mergetool" },
    { "c", ":Git commit<cr>", desc = "commit" },
    { "<Enter>", "<cmd>PopupNext Git<CR>", { exit = true }, desc = "Fugitive" },
    { "q", nil, { exit = true, nowait = true }, desc = "exit" },
  }
}
local hint = [[
 _n_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _p_: prev hunk   _U_: undo stage hunk   _P_: preview hunk   _B_: blame show full
 ^ ^              _a_: stage buffer      _r_: revert hunk    _/_: show base file
 _m_: mergetool   _c_: commit            _l_: show logs      _f_: fixup log
 ^
 ^ ^              _<Enter>_: Fugitive            _q_: exit
]]
config.hint = hint
Hydra(config)

