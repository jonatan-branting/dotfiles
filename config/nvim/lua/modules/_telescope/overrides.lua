local utils = require("modules._telescope.utils")
local resolve = require("telescope.config.resolve")

local current_horizontal_buffer = function(self, columns, lines)
  local initial_options = utils.get_initial_window_options(self)

  local window_width = math.min(columns, 120)
  local window_height = lines

  local preview = initial_options.preview
  local results = initial_options.results
  local prompt = initial_options.prompt

  -- Width
  local width_padding = resolve.resolve_width(10)(self, columns, lines)

  local width = window_width - width_padding * 2
  if not self.previewer then
    preview.width = 0
  else
    preview.width = width
  end
  results.width = width
  prompt.width = width

  -- Height
  local height_padding = math.max(
  1, resolve.resolve_height(math.min(4, math.floor(lines / 10)))(self, columns, lines)
  )

  results.height = math.floor((lines)/ 2)
  prompt.height = 1

  preview.height = window_height - results.height - prompt.height - 2 - height_padding * 2


  local line = 0
  if self.previewer then
    preview.line = height_padding + line
    prompt.line = preview.line + preview.height + 2
    results.line = prompt.line + prompt.height + 1
  else
    results.line = height_padding + line
    prompt.line = results.line + results.height + 1
  end

  local col = math.ceil((columns / 2) - (width / 2) - 1)
  preview.col, results.col, prompt.col = col, col, col

  results.title = false

  return {
    preview = preview.width > 0 and preview,
    results = results,
    prompt = prompt,
  }
end


local bottom_bar = function(self, columns, lines)
  local initial_options = utils.get_initial_window_options(self)

  local window_width = columns
  local window_height = lines/2

  local preview = initial_options.preview
  local results = initial_options.results
  local prompt = initial_options.prompt

  -- Width
  local width_padding = resolve.resolve_width(10)(self, columns, lines)

  local width = window_width - 2

  preview.width = width
  results.width = width
  prompt.width = width

  -- Height
  local height_padding = math.max(
    1, resolve.resolve_height(math.min(4, math.floor(lines / 10)))(self, columns, lines)
    )

  results.height = 10
  prompt.height = 1

  preview.height = 10


  prompt.line = lines - 2
  results.line = prompt.line - prompt.height - results.height
  preview.line = results.line - preview.height - 2

  local col =  1-- math.ceil((columns / 2) - (width / 2) - 1)
  preview.col, results.col, prompt.col = col, col, col

  results.title = false

  return {
    preview = preview.width > 0 and preview,
    results = results,
    prompt = prompt,
  }
end

return {
  setup = function()
    require'telescope.pickers.layout_strategies'.current_horizontal_buffer = current_horizontal_buffer
    require'telescope.pickers.layout_strategies'.bottom_bar = bottom_bar
  end
}
