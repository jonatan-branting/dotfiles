local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local au = require("modules.au")

local function has_value (tab, val)
  for index, value in ipairs(tab) do
    if value[1] == val then
      return true
    end
  end

  return false
end

local is_floating = function(win)
  return vim.api.nvim_win_get_config(win).relative ~= ""
end

local autocommand = function(event, pattern, command)
  return string.format([[au %s %s ++once ++nested %s]], event, pattern, command)
end

local augroup = function(name, ...)
  autocommands = {...}

  return string.format(
    [[
      augroup %s
        autocmd!
        %s
      augroup end
    ]],
    name,
    table.concat(autocommands, "\n\t")
  )
end

local delete_commands = function(...)
  groups = {...}
  for _, group in ipairs(groups) do
    vim.cmd(augroup(group))
  end
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

local create_popup_for_buffer = function(buf, command, delete_on_close)
  delete_on_close = delete_on_close or false
  buf = tonumber(buf)

  local popup = Popup(popup_config(command, buf))

  popup:mount()

  au.group("_popup_window_local_commands", {
    { "BufWinEnter", "*",
      function()
        if vim.api.nvim_get_current_win() == popup.winid then
          setup_popup_for_buffer(popup, vim.fn.expand("<abuf>"), delete_on_close)
        end
      end
    }
  })

  return popup
end

local close_split = function()
  local win = vim.api.nvim_get_current_win()

  if is_floating(win) then return end

  vim.api.nvim_win_close(win, false)
  vim.cmd("exe _popup_next_restore_win_cmd")
end

local restore_window = function (win, buf)
  vim.api.nvim_win_set_buf(win, buf)
end

local popup_next = function(command)
  before_buf = vim.api.nvim_get_current_buf()
  before_win = vim.api.nvim_get_current_win()

  vim.cmd("let _popup_next_restore_win_cmd = winrestcmd()")

  local setup_autocommands = augroup(
    "_popup_autocommands",
    autocommand("WinEnter", "*",
      string.format(
        [[lua require"modules.popup"._create_popup_for_window(vim.fn.expand("<abuf>"), '%s')]],
        command
      )
    ),
    autocommand("WinNew", "*",
      string.format([[lua require"modules.popup"._close_split()]])
    )
  )


  vim.cmd(setup_autocommands)
  vim.cmd(command)

  delete_commands("_popup_autocommands")
end

return {
  popup_next = popup_next,
  popup_current = popup_current,
  _create_popup_for_window = create_popup_for_buffer,
  _close_split = close_split,
  _restore_window = restore_window
}
