local M = {}
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local util = require('vim.lsp.util')
local ts_utils = require("nvim-treesitter.ts_utils")
local utils = require("utils")

Popup = require("nui.popup")

local function ts_parser_exists(buf)
  success, _ = pcall(function()
    vim.treesitter.get_parser(buf)
  end)

  return success
end
local function get_node_at_position(buf, ignore_injected_langs, col, row)

  local root_lang_tree = vim.treesitter.get_parser(buf)
  if not root_lang_tree then
    return
  end

  local root
  if ignore_injected_langs then
    for _, tree in ipairs(root_lang_tree:trees()) do
      local tree_root = tree:root()
      if tree_root and ts_utils.is_in_node_range(tree_root, col, row) then
        root = tree_root
        break
      end
    end
  else
    root = M.get_root_for_position(col, row, root_lang_tree)
  end

  if not root then
    return
  end

  return root:named_descendant_for_range(col, row, col, row)
end

local get_all_sibling_nodes = function(node)
  local next_nodes = {}
  local n = node
  while true do
    n = ts_utils.get_next_node(n, false, false)
    if not n then break end

    table.insert(next_nodes, n)
  end

  local prev_nodes = {}
  local n = node
  while true do
    n = ts_utils.get_previous_node(n, false, false)
    if not n then break end

    table.insert(prev_nodes, n)
  end

  return {
    unpack(prev_nodes),
    node,
    unpack(next_nodes)
  }
end

local ts_in_signature = function(buf, context)
  if not ts_parser_exists(buf) then return end

  local position = context.params.position

  local requested_node = get_node_at_position(buf, true, position.line, position.character - 1)
  if not requested_node then return false end

  local cursor_node = ts_utils.get_node_at_cursor()
  if not cursor_node then return false end

  -- print(position.character, position.line, requested_node:type(), cursor_node:type())
  if requested_node == cursor_node then
    return true
  end

  if cursor_node:parent() == requested_node then
    return true
  end

  return false
end

local ts_get_active_signature = function()
  local current_node = ts_utils.get_node_at_cursor()
  local all_nodes = get_all_sibling_nodes(current_node)

  for i, node in ipairs(all_nodes) do
    if node == current_node then
      return i
    end
  end

  return 1
end

-- local get_active_signature = function(label)
--   local current_node = ts_utils.get_node_at_cursor()
--   local start_row, start_col, end_row, end_col = unpack(current_node:range())
-- end

local function highlight_signature(buf, active_node, signature, offset)
  -- local parser = vim.treesitter.get_string_parser(text, vim.bo.filetype)
  -- local tree = parser:parse()
  local ns = vim.api.nvim_create_namespace("")
  local start, end_ = unpack(signature.parameters[active_node].label)
  -- local start, end = unpack(signature.parameters.label)
  -- print(start, end_, vim.inspect())
  vim.api.nvim_buf_add_highlight(buf, ns, "Visual", 0, start - offset, end_ - offset)
  -- vim.api.nvim_buf_set_extmark(buf, ns, 0, start , { hl_group = "Visual" })
  -- print(vim.inspect(tree:root()))
end

local function create_popup(ctx)
  local popup = Popup({
    enter = false,
    focusable = false,
    zindex = 50,
    relative = "editor",
    size = {
      width = "100%",
      height = 1
    },
    position = {
      row = "100%",
      col = 1,
    },
    buf_options = {
      modifiable = false,
      readonly = true,

    },
    win_options = {
      winblend = 12,
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
    },
  })

  local events = { "CursorMoved", "CursorMovedI", "InsertCharPre" }

  local group = augroup("LspSignatureMoved" .. popup.bufnr, {clear = true})

  popup:on(require("nui.utils.autocmd").event.WinEnter, function()
    vim.opt_local.winbar = nil
  end, {once = true})

  autocmd(events, {
    group = group,
    callback = function(data)
      vim.schedule(function()
        -- TODO only do for supported languages
        if not ts_in_signature(data.buf, ctx) then
          popup:unmount()

          pcall(function() vim.api.nvim_del_augroup_by_id(group) end)
        end
      end)
    end
  })

  return popup
end

local get_signature_handler_for_client = function(client, buf)
  return function(err, result, ctx, config)
    local _, err = pcall(function()

      local signature = result.signatures[1]
      if not signature then return end

      local popup = create_popup(ctx)
      local active_node = (signature.activeParameter and signature.activeParameter + 1)

      -- TODO add toggleable documenation, shift-k to expand it and enter it...
      if active_node then
        local padding = 15
        local start, end_ = unpack(signature.parameters[active_node].label)
        local columns = vim.api.nvim_get_option("columns")
        if columns < end_ + padding then
          local total_diff = end_ + padding - columns

          -- truncate so that we fit
          vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, {
            "..." .. string.sub(signature.label, total_diff, #signature.label),
          })
          highlight_signature(popup.bufnr, active_node, signature, total_diff - 4) -- ... + 
        else
          vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { signature.label })
          highlight_signature(popup.bufnr, active_node, signature, 0)
        end

      else
        vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { signature.label })
      end

      popup:mount()
    end)

    -- if err then print(vim.inspect(err)) end
  end
end

local check_trigger_char = function(line_to_cursor, triggers)
  if not triggers then
    return false
  end

  for _, trigger_char in ipairs(triggers) do
    local current_char = line_to_cursor:sub(#line_to_cursor, #line_to_cursor)
    local prev_char = line_to_cursor:sub(#line_to_cursor - 1, #line_to_cursor - 1)
    if current_char == trigger_char then
      return true
    end
    if current_char == ' ' and prev_char == trigger_char then
      return true
    end
  end
  return false
end

local get_trigger_characters = function(client)
  local trigger_characters = {}
  for _, c in ipairs(client.server_capabilities.signatureHelpProvider.triggerCharacters or {}) do
    table.insert(trigger_characters, c)
  end
  for _, c in ipairs((client.server_capabilities.signatureHelpProvider.reTriggerCharacters or {})) do
    table.insert(trigger_characters, c)
  end
  return trigger_characters
end

local open_signature = function(client, buf)
  local triggers = get_trigger_characters(client)

  -- csharp has wrong trigger chars for some odd reason
  -- if client.name == 'csharp' then
  --   triggers = { '(', ',' }
  -- end

  local pos = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local line_to_cursor = line:sub(1, pos[2])

  if check_trigger_char(line_to_cursor, triggers) then
    local request = util.make_position_params(0, client.offset_encoding)
    request.context = {
      triggerKind = 2,
    }

    local handler = get_signature_handler_for_client(client, buf)
    client.request("textDocument/signatureHelp", request, handler)
  end
end

M.setup = function(client)
  local group = augroup('LspSignature', { clear = false })
  vim.api.nvim_clear_autocmds({ group = group, pattern = '<buffer>' })

  autocmd('TextChangedI', {
    group = group,
    pattern = '<buffer>',
    callback = function(data)
      -- Guard against spamming of method not supported after
      -- stopping a language serer with LspStop
      local active_clients = vim.lsp.get_active_clients()
      -- print(#active_clients)
      if #active_clients < 1 then
        return
      end
      open_signature(client, data.buf)
    end,
  })
end

return M
