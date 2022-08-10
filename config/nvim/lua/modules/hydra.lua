
local Hydra = require("hydra")
local gitsigns = require("gitsigns")


local config = {
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
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
    { "S", gitsigns.stage_buffer, desc = "stage buffer"},
    { "P", gitsigns.preview_hunk, desc = "preview hunk" },
    { "d", gitsigns.toggle_deleted, { nowait = true }, desc = "show deleted" },
    { "b", gitsigns.blame_line, desc = "blame line"},
    { "B", function() gitsigns.blame_line({ full = true }) end, desc = "blame show full" },
    { "/", gitsigns.show, { exit = true }, desc = "show base file" }, -- show the base of the file
    { "<Enter>", "<cmd>PopupNext Git<CR>", { exit = true }, desc = "Fugitive" },
    { "q", nil, { exit = true, nowait = true }, desc = "exit" },
  }
}

local hint = [[
 _n_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _p_: prev hunk   _U_: undo stage hunk   _P_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      _r_: revert hunk    _/_: show base file
 ^
 ^ ^              _<Enter>_: Fugitive            _q_: exit
]]
config.hint = hint
Hydra(config)

local dap = require'dap'
local hint = [[
 _n_: step over   _\*_: to cursor   _K_: eval
 _l_: step into   _c_: continue    _r_: toggle repl 
 _o_: step out    _b_: breakpoint

 ^ ^              _q_: exit
]]

local dap = require("dap")
local dap_hydra = Hydra({
  hint = hint,
  config = {
    color = 'pink',
    invoke_on_body = true,
    hint = {
      -- position = 'middle-right',
      border = 'single'
    },
  },
  name = 'dap',
  mode = {'n','x'},
  body = '<leader>dd',
  on_enter = function()
    dap.repl.open()
  end,
  on_close = function()
    dap.repl.close()
  end,
  heads= {
    { 'n', dap.step_over, { silent = true } },
    { 'l', dap.step_into, { silent = true } },
    { 'o', dap.step_out, { silent = true } },
    { '*', dap.run_to_cursor, { silent = true } },
    { 'c', dap.continue, { silent = true } },
    -- { 'x', ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", {exit=true, silent = true } },
    -- { 'C', ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
    { 'b', dap.toggle_breakpoint, { silent = true } },
    { 'K', ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
    { 'q', dap.close, { exit = true, nowait = true } },
    { 'r', dap.repl.toggle, { silent = true }}
  }
})

return {
  dap = dap_hydra
}
