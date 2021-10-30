local colors = require('modules._feline.colors')
local path = require('plenary.path')

local fn = vim.fn
local b = vim.b

local M = {}

function M.column_component(active)
  return {
    provider = function()
      if not (vim.wo.number or vim.wo.relativenumber) then return '' end

      if active then
        local padding_width = string.len(vim.fn.line('$')) - string.len(vim.fn.col('.'))
        return " " .. string.rep(" ", padding_width) .. tostring(vim.fn.virtcol('.')) .. " "
      else
        return " " .. string.rep("-", string.len(vim.fn.line('$'))) .. " "
      end
    end,
    hl = function()
      return {
        fg = colors.bg1,
        style = "bold",
        bg = require('feline.providers.vi_mode').get_mode_color()
      }
    end
  }
end

function M.file_info_component(active)
  return {
    provider = function()
      local filetype = vim.bo.filetype

      local filename = fn.expand('%')
      local relative_filename = ""
      if filetype == "fzf" then
        relative_filename = "fzf"
      else
        relative_filename = path:new(filename):make_relative()
      end

      local file_string
      if string.len(relative_filename) > 35 then
        file_string = path:new(relative_filename):shorten()
      elseif string.len(relative_filename) == 0 then
        file_string = string.len(filetype) > 0 and filetype or 'no name'
      else
        file_string = relative_filename
      end

      local left_sep = active and "››" or "‹‹"
      local right_sep = active and "‹‹" or "››"

      if vim.bo.modified then
        return " " .. left_sep ..file_string .. right_sep .. "_ "
      end

      return " " .. left_sep ..file_string .. right_sep .. " "
    end
  }
end

-- TODO: Split this into multiple parts to properly HL the neomake component
local neomake_status = function()
  return vim.fn["neomake#statusline#get"](
    vim.api.nvim_get_current_buf(), {
      format_running = '...({{running_job_names}})',
      format_loclist_ok = '..›ok',
      format_quickfix_ok = '',
      format_quickfix_issues = '%s',
      format_loclist_unknown = '',
      format_quickfix_unknown = '',
      format_loclist_type_default = 'e^{{count}}',
      format_quickfix_type_default = 'e^{{count}}'
    }
  )
end

function M.neomake_component(active)
  return {
    provider = neomake_status
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
      local cwd = fn.getcwd():gsub('^.*/', '')

      if not b.gitsigns_status_dict then return ' ' .. cwd end


      local head = b.gitsigns_status_dict.head

      local max_head_len = 20
      if string.len(head) > max_head_len then
        head = head:sub(1, max_head_len - 3) .. '...'
      end

      if head and #head > 0 then
        return '  ' .. cwd .. '/' .. head
      else
        return ' '
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
        local icon = ' ± '
        return icon .. total_edited
      else
        return ''
      end
    end,
    hl = {
      fg = colors.fg_sides,
    }
  }
end

function M.file_diff_component()
  local provider
  if not b.gitsigns_status_dict or not vim.bo.modified then
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

function M.lsp_status_component()
  return {
    provider = function() return require('lsp-status').status() or '' end
  }
end

function M.lsp_client_names_component()
  return {
    provider = 'lsp_client_names',
    icon = '',
    left_sep = ' ',
    right_sep = '',
    hl = { style = "italic" }
  }
end

-- -- local gps = require("nvim-gps")
-- function M.treesitter_location()
--   return {
--     provider = function ()
--       if gps.is_available() then
--         return gps.get_location()
--       else
--         return ''
--       end
--     end
--   }
-- end

return M
