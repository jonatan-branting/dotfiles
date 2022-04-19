-- Copied from mjlbach/neovim-ui

local utils = require('ui._utils')

vim.api.nvim_command("hi NotificationInfo guifg=#80ff95")
vim.api.nvim_command("hi NotificationWarning guifg=#fff454")
vim.api.nvim_command("hi NotificationError guifg=#c44323")

local function notification(message, options)
  if type(message) == "string" then
    message = { message }
  end

  if type(message) ~= "table" then
    error("First argument has to be either a table or a string")
  end

  options = options or {}
  options.type = options.type or "info"
  options.delay = options.delay or 2000

  local width = utils.tbl_longest_str(message)
  local height = #message
  local row = options.row
  local col = vim.api.nvim_get_option("columns") - 3

  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, message)

  local window = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    anchor = "SE",
    height = height,
    style = "minimal"
  })

  local log_level = options.log_level or 0

  if log_level <= 3 then
    vim.api.nvim_win_set_option(window, "winhl", "Normal:NotificationInfo")
  elseif log_level == 4 then
    vim.api.nvim_win_set_option(window, "winhl", "Normal:NotificationWarning")
  else
    vim.api.nvim_win_set_option(window, "winhl", "Normal:NotificationError")
  end

  local timer
  local delete = function()

    if timer:is_active() then
      timer:stop()
    end

    if vim.api.nvim_win_is_valid(window) then
      vim.api.nvim_win_close(window, false)
    end
  end

  timer = vim.defer_fn(delete, options.delay)

  return {
    window = window,
    height = height,
    width = width,
    row = row,
    col = col,
    content = message,
    delete = delete
  }
end

-- Override notify functions, so that LSP's automatically output their messages
-- through a notification, instead of an echo
-- _G.vim.notify = function(msg, log_level)
--   notification({msg}, { row = 0, log_level = log_level })
-- end
