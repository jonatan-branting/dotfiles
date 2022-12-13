local Popup = require("nui.popup")
local event = require("nui.utils.autocmd").event
local utils = require("utils")
-- TODO support for debugger!
-- i.e. make different providers


local function window_contains_cursor(winnr, cursor_pos)
  -- TODO refactor using Position/Range
  local crow, ccol = unpack(cursor_pos)
  local row, col = unpack(vim.api.nvim_win_get_position(winnr))
  local height, width = unpack({
    vim.api.nvim_win_get_height(winnr),
    vim.api.nvim_win_get_width(winnr)
  })

  if row <= crow and crow <= row + height and
      col <= ccol and ccol <= col + width then
    return true
  end

  return false
end

local function get_window_at_pos(cursor_pos)
  for _, winnr in ipairs(vim.api.nvim_list_wins()) do
    if window_contains_cursor(winnr, cursor_pos) then
      return winnr
    end
  end
end

local function build_lines(diagnostics)
  local lines = {}

  -- TODO highlight
  -- TODO cannot contain newlines apparently, fix this
  --

  for i, diagnostic in ipairs(diagnostics) do
    local line = i .. "." .. diagnostic.message

    if diagnostic.source then
      line = line .. " (" .. diagnostic.source .. ")"
    end

    table.insert(lines, line)
    table.insert(lines, "")
  end

  return lines
end

local function create_diagnostics_window_at_screen_pos(diagnostics, pos)
  -- print(vim.inspect(diagnostics))
  local lines = build_lines(diagnostics)
  local max_width = 56
  local max_line_length = 0
  local rows = 0
  for _, line in ipairs(lines) do
    rows = rows + math.ceil(#line / max_width)
    max_line_length = math.max(max_line_length, #line)
  end

  local popup = Popup({
    enter = false,
    focusable = true,
    relative = "editor",
    border = {
      style = "solid",
      -- text = {
      --   top = "Diagnostics",
      --   top_align = "center"
      -- }
    },
    position = {
      row = pos[1],
      col = pos[2]
    },
    size = {
      height = math.min(rows, 10),
      width = math.min(max_line_length + 1, max_width) -- should depend on the message
    }
  })


  vim.api.nvim_create_autocmd(
    {
      "WinScrolled",
      "TextChanged",
      "TextChangedI",
      "ModeChanged",
    },
    {
      once = true,
      callback = function()
        vim.schedule(function()
          popup:unmount()
        end)
      end
    }
  )
  vim.api.nvim_create_autocmd("User",
    {
      pattern = "MouseHoverLeave",
      once = true,
      callback = function()
        vim.schedule(function()
          popup:unmount()
        end)
      end
    }
  )
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  popup:mount()

  -- print("popupwinid", popup.winid)
  vim.api.nvim_win_set_option(popup.winid, "wrap", true)
  vim.api.nvim_win_set_option(popup.winid, "breakindent", true)
  vim.api.nvim_win_set_option(popup.winid, "breakindentopt",
    "shift:3,min:40,sbr"
  )

  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
end


local group = vim.api.nvim_create_augroup("FocusWindowOnHover", {})
vim.api.nvim_create_autocmd(
  "User", {
    group = group,
    pattern = "MouseHoverEnter",
    callback = function (args)
      local cursor_pos = { args.data.position.screenrow, args.data.position.screencol }

      vim.schedule(function()
        -- TODO ignore if not a window!
        local window_below_cursor = get_window_at_pos(cursor_pos)
        if window_below_cursor then
          vim.api.nvim_set_current_win(window_below_cursor)
        end
      end)
    end
  }
)

vim.api.nvim_create_autocmd(
  "User", {
    group = group,
    pattern = "MouseHoverEnter",
    callback = function (args)
      -- get diagnostics under cursor
      local cursor_screen_pos = { args.data.position.screenrow, args.data.position.screencol }
      local cursor_win_pos = { args.data.position.line - 1, args.data.position.column }

      local winnr = get_window_at_pos(cursor_screen_pos)
      if not winnr then return end

      local bufnr = vim.api.nvim_win_get_buf(winnr)

      local diagnostics = vim.diagnostic.get(bufnr, { lnum = cursor_win_pos[1] })

      if #diagnostics > 0 then
        create_diagnostics_window_at_screen_pos(diagnostics, cursor_screen_pos)
      end
    end
  }
)
