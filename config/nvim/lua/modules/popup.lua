local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("utils")

local delete_commands = function(...)
  local groups = {...}
  for _, group in ipairs(groups) do
    vim.api.nvim_create_augroup(group, { clear = true })

    -- This throws an error if it doesn't exist, which is something we do not
    -- want, as this might be called multiple times
    -- vim.api.nvim_del_augroup_by_name(group)
  end
end

local popup_config = function(command, buf)
  return {
    enter = true,
    focusable = true,
    border = {
      style = "solid", -- TODO make this configurable?
      -- text = {
      --   top = command,
      --   top_align = "center"
      -- }
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

  popup:map("n", "q", close, {}, true)
  popup:on(event.WinLeave, defer_close, { nested = true })
  popup:on(event.BufWipeout, defer_close, { nested = true })
  popup:on(event.WinScrolled, function()
    if not popup.winid then return end

    -- Make sure the windows aren't downsized
    vim.api.nvim_win_set_width(popup.winid, math.floor(vim.go.columns * 0.9))
    vim.api.nvim_win_set_height(popup.winid, math.floor(vim.go.lines * 0.8))
  end, { nested = true, once = true})

  return popup
end

local create_popup_for_buffer = function(buf, command, delete_on_close)
  delete_commands("_popup_autocommands")

  delete_on_close = delete_on_close or false
  buf = tonumber(buf)

  local popup = Popup(popup_config(command, buf))

  popup:mount()

  vim.api.nvim_create_augroup("_popup_window_local_commands", { clear = true })

  vim.api.nvim_create_autocmd("BufWinEnter", {
      group = "_popup_window_local_commands",
      callback = function()
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

  pcall(function() vim.cmd(command) end)

  delete_commands("_popup_autocommands")
end

local popup_current = function(command)
  vim.cmd("let _popup_next_restore_win_cmd = winrestcmd()")

  vim.api.nvim_create_augroup("_popup_autocommands", { clear = true })

  close_split()
  create_popup_for_buffer(vim.fn.expand("<abuf>"), command)

  vim.cmd(command)

  delete_commands("_popup_autocommands")
end

local setup = function()
  vim.cmd [[
    command! -complete=command -nargs=+ PopupNext :lua require("plenary.reload").reload_module("modules.popup", true); require("plenary.reload").reload_module("modules.au", true); require("modules.popup").popup_next(<q-args>)
  ]]

  vim.cmd [[
    command! -nargs=? PopupCurrent :lua require("plenary.reload").reload_module("modules.popup", true); require("modules.popup").popup_current(<q-args>)
  ]]
end

return {
  popup_next = popup_next,
  popup_current = popup_current,
  setup = setup
}
