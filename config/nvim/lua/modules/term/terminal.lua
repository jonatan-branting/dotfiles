local utils = require("utils")

local Terminal = {}

local function new_split(term)
  if vim.api.nvim_win_is_valid(term.winnr) then
    return term.winnr
  end

  local flip_columns = 140

  if vim.go.columns < flip_columns then
    vim.cmd(("split +buffer%d"):format(term.bufnr))
  else
    vim.cmd(("vert split +buffer%d"):format(term.bufnr))
  end

  return vim.api.nvim_get_current_win()
end

Terminal.opts = {
  shell = vim.go.shell,
  on_exit = function() end,
  on_stdout = function() end,
  on_stderr = function() end,
  win_func = new_split,
}

function Terminal.setup(opts)
  Terminal.opts = vim.tbl_deep_extend("force", Terminal.opts, opts)
end

function Terminal:new(idx)
  local term = {
    bufnr = -1,
    autocmd_group = vim.api.nvim_create_augroup("Terminal" .. idx, {}),
    winnr = -1,
    jobid = -1,
  }

  setmetatable(term, self)
  self.__index = self

  self:__setup_autocmds()

  return term
end

function Terminal:__create_win()
  self.winnr = self.opts.win_func(self)
  self:__setup_win()
end

function Terminal:__set_buf()
  vim.api.nvim_set_current_buf(self.bufnr)
end

function Terminal:__setup_win()
  vim.cmd("setlocal nospell")
  vim.cmd("setlocal nonumber")
  vim.cmd("setlocal buflisted")
  vim.cmd("setlocal filetype=term")
  vim.cmd("setlocal norelativenumber")
  vim.cmd("setlocal signcolumn=no")
  vim.cmd("setlocal winhighlight=Normal:Normal")
end

function Terminal:__setup_autocmds()
  -- vim.api.nvim_create_autocmd(
  --   "User",
  --   {
  --     group = self.autocmp_group,
  --     buffer = self.bufnr,
  --     pattern = "TerminalFocused",
  --     callback = function(opts)
  --       -- print("TerminalFocused")
  --       if not opts.buf == opts.data.bufnr then return end
  --       vim.schedule(function()
  --         if not vim.api.nvim_get_current_win() == opts.data.winnr then
  --           return
  --         end

  --         vim.cmd.startinsert()
  --       end)
  --     end
  --   }
  -- )
  vim.api.nvim_create_autocmd(
    "User",
    {
      group = self.autocmd_group,
      buffer = self.bufnr,
      pattern = "TerminalCmdSent",
      callback = function(opts)
        local term = require("modules.term"):get_terminal(opts.data.idx)
        vim.schedule(function()
          term:scroll_to_bottom()
        end)
        -- -- print("TerminalCmdSent", vim.inspect(opts))
        -- vim.schedule(function() self:scroll_to_bottom() end)
      end
    }
  )
  -- vim.api.nvim_create_autocmd(
  --   "BufDelete",
  --   {
  --     buffer = self.bufnr,
  --     group = self.autocmd_group,
  --     callback = function(opts)
  --       print("BufDelete", vim.inspect(opts))
  --       if not opts.buf == self.bufnr then return end
  --       if not vim.api.nvim_buf_is_valid(opts.buf) then return end

  --       vim.schedule(function() self:close() end)
  --     end
  --   }
  -- )
  -- vim.api.nvim_create_autocmd(
  --   "BufWinLeave",
  --   {
  --     buffer = self.bufnr,
  --     group = self.autocmd_group,
  --     callback = function()
  --       print("BufWinLeave")
  --       print(vim.inspect(self))
  --       self.winnr = -1
  --     end
  --   }
  -- )
  -- vim.api.nvim_create_autocmd(
  --   "BufWinEnter",
  --   {
  --     buffer = self.bufnr,
  --     group = self.autocmd_group,
  --     callback = function(opts)
  --       -- print("BufWinEnter", vim.inspect(opts))
  --       vim.schedule(function()
  --         print("original_winnr", self.winnr, "new_winnr", vim.api.nvim_get_current_win())
  --         self.winnr = vim.api.nvim_get_current_win()
  --       end)
  --     end
  --   }
  -- )
end

function Terminal:__start_terminal()
  -- TODO create something like `exec_in_buf(buf, function() ... end)`
  self.jobid = vim.fn.termopen(self.opts.shell, {
    on_exit = function()
      self:close()
    end,
    on_stdout = self.opts.on_stdout,
    on_stderr = self.opts.on_stderr,
    cwd = vim.fn.getcwd(),
  })
end

function Terminal:spawn()
  if not vim.api.nvim_buf_is_valid(self.bufnr) then
    self.bufnr = vim.api.nvim_create_buf(false, true)
  end

  self:__create_win()
  self:__start_terminal()

  vim.api.nvim_exec_autocmds("User", {
    pattern = "TerminalSpawned",
    data = { term = self },
  })
end

function Terminal:send(cmd, interactive)
  interactive = interactive or false

  local previous_window = vim.api.nvim_get_current_win()
  if not self:already_displayed() then
    self:spawn_or_focus()
  end

  vim.schedule(function()
    -- TODO should show but not focus
    vim.fn.chansend(self.jobid, utils.t("<c-c>") .. cmd .. utils.t("<cr>"))
    -- print("executing " .. cmd, "jobid:", self.jobid)

    vim.api.nvim_exec_autocmds("User", {
      pattern = "TerminalCmdSent",
      data = { bufnr = self.bufnr, cmd = cmd, winnr = self.winnr, idx = self.idx },
    })

    if not interactive then
      vim.api.nvim_set_current_win(previous_window)
      vim.api.nvim_feedkeys(utils.t("<esc>"), "n", true)
    end
  end)
end

function Terminal:scroll_to_bottom()
  vim.api.nvim_buf_call(
    self.bufnr,
    function()
      vim.cmd("normal! G")
    end
  )
end

function Terminal:close()

  self:update_window()
  print("Terminal:close()", vim.inspect(self))
  -- TODO teardown
  if vim.api.nvim_win_is_valid(self.winnr) then
    vim.api.nvim_win_close(self.winnr, true)
  end

  if vim.api.nvim_buf_is_valid(self.bufnr) then
    vim.api.nvim_buf_delete(self.bufnr, { force = true })
  end

  if self:job_is_valid() then
    vim.fn.jobstop(self.jobid)
  end

  self.bufnr = -1
  self.winnr = -1
  self.jobid = -1

  vim.api.nvim_exec_autocmds("User", {
    pattern = "TerminalClosed",
    data = { bufnr = self.bufnr, winnr = self.winnr },
  })
end

function Terminal:spawn_or_focus()
  if not self:has_started() then
    self:spawn()
  end

  self:update_window()
  self:focus()
end

function Terminal:windows()
  local windows = {}
  for _, winid in ipairs(vim.fn.win_findbuf(self.bufnr)) do
    table.insert(windows, vim.fn.win_id2win(winid))
  end

  return vim.fn.win_findbuf(self.bufnr)
  -- return windows
end

function Terminal:already_displayed()
  return #self:windows() > 0
end

function Terminal:toggle()
  self:update_window()
  if self:already_displayed() then
    self:hide()
  else
    self:spawn_or_focus()
  end
end

function Terminal:hide()
  vim.api.nvim_win_close(self.winnr, true)
end

function Terminal:job_is_valid()
  return vim.fn.jobwait({ self.jobid }, 0)[1] == -1
end

function Terminal:is_alive()
  return vim.api.nvim_buf_is_valid(self.bufnr) and self:job_is_valid()
end

function Terminal:update_window()
  if self:already_displayed() then
    self.winnr = self:windows()[1]
  end
end

function Terminal:focus()
  self:update_window()

  if vim.api.nvim_win_is_valid(self.winnr) then
  elseif self:already_displayed() then
    self.winnr = self:windows()[1]
  else
    self:__create_win()
  end

  vim.api.nvim_set_current_win(self.winnr)
  vim.api.nvim_exec_autocmds("User", {
    pattern = "TerminalFocused",
    data = { bufnr = self.bufnr, winnr = self.winnr },
  })
end

function Terminal:has_started()
  return self.jobid ~= nil and vim.api.nvim_buf_is_valid(self.bufnr)
end

-- test ---
-- kill all terminal buffers
pcall(function() vim.cmd("bdelete! term://*") end)
pcall(function() vim.cmd("bdelete! [No Name]:*") end)

Terminal.setup({
  shell = "fish",
})

return Terminal

