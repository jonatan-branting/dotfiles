local utils = require("utils")

local selection_utils = require("modules.selection.utils")
local Session = require("modules.selection.session")
local Selection = require("modules.selection.selection")
local Range = require("modules.lib.range")

local M = {}

M.sessions = {}

setmetatable(M.sessions, {
  __index = function(table, bufnr)
    local session = Session:new(bufnr)
    table[bufnr] = session

    return session
  end
})

local function get_current_session()
  local bufnr = vim.api.nvim_get_current_buf()

  return M.sessions[bufnr]
end

M.get_current_session = get_current_session

function M.clear_highlights()
  get_current_session():clear_highlights()
end

function M.generate_targets(selections)
  return selection_utils.generate_targets(selections)
end

function M.clear_selection()
  get_current_session():clear_selection()
end

-- expect 1, 1 based ranges
function M.select_range(range, opts)
  local opts = opts or {}

  local session = get_current_session()

  local start_row, start_col, end_row, end_col = unpack(range)
  if end_col == -1 then
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, true)
    end_col = #lines[#lines] + 1
  end
  range = {start_row, start_col, end_row, end_col}
  return session:select_range(range, opts)
  -- local containing_selections = session:get_selections_containing_range(range)

  -- if #containing_selections == 0 or opts.ephemeral then -- refactor this, this is just bad

  -- end
end

-- TODO allow extending selections...
-- multiple selections will have to wait til single selections are complete
--problem with that is that I run clear_selection everywhere..., which isn't something we should do.
-- 
-- 

-- move out to ./operators/
function M.opfunc()
  -- siw
  local session = get_current_session()
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(session.bufnr, "["))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(session.bufnr, "]"))

  -- marks are 1, 0 based, convert to vim-range
  local range = utils.vim_range_from_mark({start_row, start_col, end_row, end_col})

  -- 1, 1 indexed
  get_current_session():clear_selection()
  get_current_session():select_range(range, {})
end

-- TODO make this a lot simpler but expose callback and customization functionality.
-- if only 1 cursor, instantly
-- add ACTUAL multicursor support
-- i.e. the same as a selction, but it's basically just a pointer to a location, on which we can run selectors to add selections to the buffer
-- when we move using one of our mapped movement keybindings, simply execute
-- this on all locations (vim.api.nvim_set_cursor), which will create
-- selections
-- d and c and such then has these selections marked, and if we run such an interactive command, it will instantly jump into norm preview mode,
-- if not, (also remap <esc> to confirm...) it will simply run the command at the location and confirm for you (still using norm preview mode)
-- Keep `selection` clean
function M.motion(opts)
  print(">enter motion")

  local session = get_current_session()
  local defaults = {
    preselect = true,
    reverse = false,
    selections = session.selections,
    operator = vim.v.operator,
  }

  local opts = utils.merge(defaults, opts or {})

  vim.v.operator = nil

  -- perhaps there is a better way to do this, but this
  -- allows us to wait for the next ex_normal_preview command
  vim.api.nvim_feedkeys(utils.t("<esc>"), "n", false)

  vim.schedule(function()
    require("modules.ex_normal_preview").setup("SM", {
      ephemeral = true,
      targets = function() return selection_utils.generate_targets(opts.selections) end,
      preselect = opts.preselect,
      reverse = opts.reverse,
    })

    -- TODO make feedkeys part of exnormal preview and auto tear down on cancel
    -- as well
    vim.api.nvim_feedkeys(utils.t("<esc>:SM<space>" .. opts.operator), "n", false)
  end)
end

-- what is the current selection? is there such a thing?
function M.execute_operator(operator, opts)
  local session = get_current_session()
  local defaults = {
    preselect = true,
    reverse = false,
    selections = session.selections,
    interactive = false,
  }

  local opts = utils.merge(defaults, opts or {})

  require("modules.ex_normal_preview").setup("SM", {
    ephemeral = true,
    targets = function() return selection_utils.generate_targets(opts.selections) end,
    preselect = opts.preselect,
    reverse = operator,
  })
  if opts.interactive and #session.selections > 1 then
    vim.api.nvim_feedkeys(utils.t("<esc>:SM<space>" .. operator), "n", false)
  end
  vim.cmd("SM " .. operator)
end

function M.setup()
  vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI", "TextChangedP"},
    {
      callback = function()
        local success, err_msg = pcall(function()
          get_current_session():render_highlights()
        end)

        if not success then
          print("error highlighting selections:", err_msg)
        end
      end
    }
  )
end

return M
