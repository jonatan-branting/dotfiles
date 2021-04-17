local colors = require('plugins._feline.colors')
local path = require('plenary.path')

local fn = vim.fn
local b = vim.b
local bo = vim.bo

local M = {}

function M.column_component(active)
  return {
    provider = function()
      if not (vim.wo.number or vim.wo.relativenumber) then return '' end

      local col = vim.fn.col('.')

      local total_width = vim.fn.wincol() - vim.fn.virtcol('.') - 1

      if true or active then
        local padding_width = total_width - vim.fn.strlen(vim.fn.col('.'))
        local padding = string.rep(" ", padding_width)
        return padding .. tostring(col) .. " "
      else
        return " " .. string.rep("-", total_width) .. " "
      end
    end,
    hl = {
      fg = colors.bg1,
    }
  }
end

function M.file_info_component(active)
  return {
    provider = function()
      local filename = fn.expand('%')
      local relative_filename = path:new(filename):make_relative()

      local file_string
      if string.len(relative_filename) > 34 then
        file_string = path:new(relative_filename):shorten()
      elseif string.len(relative_filename) == 0 then
        local filetype = vim.bo.filetype
        file_string = string.len(filetype) > 0 and filetype or 'no name'
      else
        file_string = relative_filename
      end

      if active then
        return  " ››"  .. file_string  .. "‹‹ "
      else
        return " ‹‹" .. file_string .. "›› "
      end
    end
  }
end

local ale_counts = function()
  return vim.fn["ale#statusline#Count"](vim.api.nvim_get_current_buf())
end

function M.diagnostic_errors_component()
  return {
    provider = function ()
      local counts = ale_counts()
      local errors = counts.error + counts.style_error

      return errors > 0 and ' •' .. errors or ''
    end,
    hl = { fg = colors.bright_red }
  }
end

function M.diagnostic_warnings_component()
  return {
    provider = function()
      local counts = ale_counts()
      local warnings = counts.warning + counts.style_warning

      return warnings > 0 and ' •' .. warnings or ''
    end,
    hl = { fg = colors.bright_yellow}
  }
end

function M.diagnostic_info_component()
  return {
    provider = function()
      local info = ale_counts().info
      return info > 0 and ' •' .. info or ''
    end,
    hl = { fg = colors.bright_aqua}
  }
end

function M.git_branch_component()
  return {
    provider = function()
      if not b.gitsigns_status_dict then return ' <untracked>' end

      local head = b.gitsigns_status_dict.head

      if head and #head > 0 then
        return '  ' .. head
      else
        return ''
      end
    end,
    hl = {
      fg = colors.bg1,
      style = 'bold'
    },
  }
end

function M.git_diff_added_component()
  return {
    provider = function()
      if b.gitsigns_status_dict and b.gitsigns_status_dict['added']
        and b.gitsigns_status_dict['added'] > 0 then
        return ' ' .. b.gitsigns_status_dict.added
      else
        return ''
      end
    end,
    hl = {
      fg = colors.faded_green,
    }
  }
end

function M.git_diff_changed_component()
  return {
    provider = function()
      if b.gitsigns_status_dict and b.gitsigns_status_dict['changed']
        and b.gitsigns_status_dict['changed'] > 0 then
        local icon = '  柳'
        return icon .. b.gitsigns_status_dict.changed
      else
        return ''
      end
    end,
    hl = {
      fg = colors.faded_yellow,
    }
  }
end

function M.git_diff_removed_component()
  return {
    provider = function()
      if b.gitsigns_status_dict and b.gitsigns_status_dict['removed']
        and b.gitsigns_status_dict['removed'] > 0 then
        local icon =  ' '
        return icon .. b.gitsigns_status_dict.removed
      else
        return ''
      end
    end,
    hl = {
      fg = colors.faded_red,
    }
  }
end

function M.git_diff_total_edited_component()
  return {
    provider = function()
      local status = b.gitsigns_status_dict
      local total_edited = status and (
        (status.changed or 0) + (status.added or 0) + (status.removed or 0)
      ) or 0

      if total_edited > 0 then
        local icon = ' 柳'
        return icon .. total_edited
      else
        return ''
      end
    end,
    hl = {
      fg = colors.faded_yellow,
    }
  }
end

function M.file_diff_component()
  local provider
  if not b.gitsigns_status_dict or not bo.modified then
    provider = ''
  else
    provider = '  '
  end

  return {
    provider = provider,
    hl = {fg = colors.faded_yellow}
  }
end

function M.spacing_component()
  return {
    provider = ' '
  }
end

function M.lsp_client_names_component()
  return {
    provider = 'lsp_client_names',
    icon = '‹',
    left_sep = ' ',
    right_sep = ' '
  }
end

return M
