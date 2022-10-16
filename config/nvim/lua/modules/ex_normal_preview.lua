local ts_utils = require("nvim-treesitter.ts_utils")
local ts_indent = require("nvim-treesitter.indent")
local utils = require("utils")


local function seq(a, b)
  local sequence = {}

  for i = a, b do
    table.insert(sequence, i)
  end

  return sequence
end

local original_curpos = {}
local original_vispos = {}
local original_changepos = {}

local function backup_cursor()
  local _, row, col, _ = unpack(vim.fn.getpos("."))
  assert(row and row >= 0 and col and col >=0, "invalid row/col: " .. row .. ", " .. col)
  original_curpos = { row, col }

  local _, start_row, start_col, _ = unpack(vim.fn.getpos("`<"))
  local _, end_row, end_col, _ = unpack(vim.fn.getpos("`>"))
  original_vispos = { start_row, start_col, end_row, end_col }

  _, start_row, start_col, _ = unpack(vim.fn.getpos("`["))
  _, end_row, end_col, _ = unpack(vim.fn.getpos("`]"))
  original_changepos = { start_row, start_col, end_row, end_col }
end

local function restore_cursor()
  local row, col = unpack(original_curpos)
  vim.fn.setpos(".", { 0, row, col, 0 })

  local start_row, start_col, end_row, end_col = unpack(original_vispos)
  vim.fn.setpos("'<", { 0, start_row, start_col, 0 })
  vim.fn.setpos("'>", { 0, end_row, end_col, 0 })
  vim.fn.setpos("'<", { 0, start_row, start_col, 0 })
  vim.fn.setpos("'<", { 0, start_row, start_col, 0 })

  start_row, start_col, end_row, end_col = unpack(original_changepos)
  vim.fn.setpos("']", { 0, end_row, end_col, 0 })
  vim.fn.setpos("'[", { 0, start_row, start_col, 0 })
end

-- and apparently it doesnt work with global...
local function execute_on_targets(targets, cmd, opts)
  -- Jump to each and execute the command sequence.
  local ns = opts.ns or vim.api.nvim_create_namespace("")
  vim.v.operator = nil

  -- This is done to fix the cursor position in insert mode
  vim.keymap.set({"i"}, "<c-1>", "<c-o>", {  buffer = true })
  vim.keymap.set({"i"}, "<c-q>", "<c-o>", {  buffer = true })

  -- backup_cursor()
  vim.cmd("delmarks < > s e") -- register clobberer :(
  for _, target in ipairs(targets) do
    if type(target) == "function" then
      target = target()
    end

    local start_row, start_col, end_row, end_col = unpack(target.pos)
    vim.fn.cursor(start_row, start_col)
    print("asd", start_row, start_col, end_row, end_col)

    -- TODO: setmark?
    -- marks are 1, 0 based, we have supplied 1,1 based
    vim.api.nvim_buf_set_mark(0, "s", start_row, start_col - 1, {})
    if end_row and end_col then
      vim.api.nvim_buf_set_mark(0, "e", end_row, end_col - 1, {})
    end

    if false and opts.preselect then
      vim.cmd('exe "normal g`svg`e' .. cmd .. '\\<c-1>"')

    elseif false and opts.reverse then
      vim.cmd('exe "normal g`e' .. cmd .. '\\<c-1>"')
    else
      vim.cmd('exe "normal ' .. cmd .. '"')-- .. '\\<c-1>"')
    end

    -- local mode = vim.fn.mode()
    -- if not (mode  == "v" or mode == "V") then
    --   vim.cmd("delmarks < > ^")
    -- end

    if opts.preview then
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))

      local _, start_row, start_col, _= unpack(vim.fn.getpos("'<"))
      local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))
      local lines = seq(start_row, end_row)

      if start_row ~= 0 then
        if start_row == end_row then
          vim.api.nvim_buf_add_highlight(
            0, ns, "Visual", start_row - 1, start_col - 1, end_col)
        else
          vim.api.nvim_buf_add_highlight(0, ns, "Visual", start_row - 1, start_col, -1)
          for _, r in ipairs(lines) do
            vim.api.nvim_buf_add_highlight(0, ns, "Visual", r - 1, 1, -1)
          end
          vim.api.nvim_buf_add_highlight(0, ns, "Visual", end_row - 1, 1, end_col)
        end
      end
      vim.api.nvim_buf_add_highlight(0, ns, "Cursor", row - 1, col, col + 1)
    end

    -- restore_cursor()
  end
end

local function generate_targets_from_rows(rows)
  local targets = {}
  for _, row in ipairs(rows) do
    -- ignore empty lines
    local content = vim.api.nvim_buf_get_lines(0, row - 1, row, true)[1]

    -- strip whitespace
    content = content:gsub("^%s*(.-)%s*$", "%1")

    if #content > 0 then
      local col = vim.fn.indent(row)
      local target = { pos = { row, col + 1 } }

      table.insert(targets, target)
    end
  end
  return targets
end

local function default_targets_function(opts)
  return function()
    return generate_targets_from_rows(seq(opts.line1, opts.line2))
  end
end

local function setup_user_command(name, args)
  local args = args or {}
  local ephemeral = args.ephemeral or false
  local name = name or "Normal"
  -- if args.targets and type(args.targets) == "function" then
  --   print("targets:", vim.inspect(args.targets()))
  -- end

  if not ephemeral then
    vim.api.nvim_create_user_command(name,
      function(opts)
        -- print(vim.inspect(line_occurrences))
        local targets = args.targets or default_targets_function(opts)
        execute_on_targets(targets(), opts.args, { preview =true, preselect = args.preselect, reverse = args.reverse})
      end,
      {
        nargs = 1,
        range = true,
        preview = function(opts, ns)
          local targets = args.targets or default_targets_function(opts)
          execute_on_targets(targets(), opts.args, {ns = ns, preview = true,  preselect = args.preselect, reverse = args.reverse})

          return 1
        end
      }
    )
  else
    vim.api.nvim_buf_create_user_command(0, name,
      function(opts)
        local targets = args.targets or default_targets_function(opts)
        -- print(vim.inspect(targets()))
        execute_on_targets(targets(), opts.args, { preselect = args.preselect, reverse = args.reverse })

        vim.schedule(function()
          vim.api.nvim_buf_del_user_command(0, name)
        end)
      end,
      {
        nargs = 1,
        range = true,
        preview = function(opts, ns)
          local targets = args.targets or default_targets_function(opts)

          execute_on_targets(targets(), opts.args, {ns = ns, preview = true, preselect = args.preselect, reverse = args.reverse})
          return 1
        end
      }
    )
  end
end

setup_user_command()

return {
  setup = setup_user_command
}
