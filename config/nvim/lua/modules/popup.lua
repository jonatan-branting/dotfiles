local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("utils")

local delete_commands = function(...)
  groups = {...}
  for _, group in ipairs(groups) do
    vim.api.nvim_create_augroup(group, { clear = true })

    -- This throws an error if it doesn't exist, which is something we do not want, as this might be called multiple times
    -- vim.api.nvim_del_augroup_by_name(group)
  end
end

local popup_config = function(command, buf)
  return {
    enter = true,
    focusable = true,
    border = {
      style = "single",
      text = {
        top = command,
        top_align = "center"
      }
    },
    position = "35%",
    size = {
      width = "90%",
      height = "80%",
    },
    bufnr = buf,
    relative = "editor"
  }
end

local function setup_popup_for_buffer(popup, buf, delete_on_close)
  popup.bufnr = tonumber(buf)

  local close = function()
    popup:unmount()
    delete_commands("_popup_autocommands", "_popup_window_local_commands")

    if delete_on_close then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  local defer_close = function() vim.schedule(close) end

  popup:map("n", "<esc>", close, {}, true)
  popup:on(event.WinLeave, defer_close, { nested = true })
  popup:on(event.BufWipeout, defer_close, { nested = true })

  return popup
end

local create_popup_for_buffer = function(buf, command, delete_on_close)
  delete_on_close = delete_on_close or false
  buf = tonumber(buf)

  local popup = Popup(popup_config(command, buf))

  popup:mount()

  vim.api.nvim_create_augroup("_popup_window_local_commands", { clear = true })

  vim.api.nvim_create_autocmd(
    "BufWinEnter", { group = "_popup_window_local_commands", callback = function()
        if vim.api.nvim_get_current_win() == popup.winid then
          setup_popup_for_buffer(popup, vim.fn.expand("<abuf>"), delete_on_close)
        end
    end
    }
  )

  return popup
end

local close_split = function()
  local win = vim.api.nvim_get_current_win()

  if utils.is_floating(win) then return end

  vim.api.nvim_win_close(win, false)
  vim.cmd("exe _popup_next_restore_win_cmd")
end

local popup_next = function(command)
  before_buf = vim.api.nvim_get_current_buf()
  before_win = vim.api.nvim_get_current_win()

  vim.cmd("let _popup_next_restore_win_cmd = winrestcmd()")

  vim.api.nvim_create_augroup("_popup_autocommands", { clear = true })

  vim.api.nvim_create_autocmd("WinEnter", {
    nested = true, once = true, group = "_popup_autocommands",
    callback = function()
      create_popup_for_buffer(vim.fn.expand("<abuf>"), command)
    end
  })

  vim.api.nvim_create_autocmd("WinNew", {
    nested = true, once = true, group = "_popup_autocommands",
    callback = function()
      close_split()
    end
  })

  vim.cmd(command)

  delete_commands("_popup_autocommands")
end

return {
  popup_next = popup_next,
}
