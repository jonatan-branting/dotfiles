local autocmd = require("modules.autocmd")
local utils = require("utils")

local latest_movement_cmd = {
  mode = "n",
  key = "n"
}

local mappings_table = {
  ["<leader>hn"] = {"<leader>hn", "<leader>hp"},
  ["<leader>hp"] = {"<leader>hn", "<leader>hp"},

  ["{"] = {"}", "{"},
  ["}"] = {"}", "{"},

  ["<c-d>"] = {"<c-d>", "<c-u>"},
  ["<c-u>"] = {"<c-d>", "<c-u>"},

  ["/"] = {"n", "<s-n>"},
  ["*"] = {"n", "<s-n>"},
  ["?"] = {"<s-n>", "n"},
  ["#"] = {"<s-n>", "n"},
  ["f"] = {";", ","},
  ["t"] = {";", ","},
  ["F"] = {",", ";"},
  ["T"] = {",", ";"},
}

local execute_map = function(map)
  vim.api.nvim_feedkeys(utils.t("<plug>" .. map), latest_movement_cmd.mode, false)
end

local setup_autocmds = function()
  autocmd.subscribe("MappingExecuted", function(mode, key)
    if key == "n" then
      return
    end

    -- Clear highlighting, indicating that `n` will not goto the next
    -- highlighted search-term
    vim.cmd [[ nohl ]]

    latest_movement_cmd.mode = mode
    latest_movement_cmd.key = key
  end)
end

local n = function()
  execute_map(mappings_table[latest_movement_cmd.key][1])
end

local shift_n = function()
  execute_map(mappings_table[latest_movement_cmd.key][2])
end

local action_from_key = function(mode, key)
  local transformed_key = utils.t(key)

  for _, keymap in pairs(vim.api.nvim_get_keymap(mode)) do
    if keymap.lhs == transformed_key then
      return keymap.callback or keymap.rhs
    end
  end
end

local register_key = function(mode, key)
  -- TODO doesn't support buffer local mappings properly.

  -- Store the original keymap in a <plug> keybind, so we can reuse the
  -- functionality
  local action = action_from_key(mode, key) or key
  vim.keymap.set(mode, "<plug>" .. key, action, {silent = true})

  vim.keymap.set(mode, key, function()
    autocmd.emit("MappingExecuted", mode, key)
    vim.api.nvim_feedkeys(utils.t("<plug>" .. key), mode, false)
  end)
end

local setup = function(opts)
  -- TODO:
  -- 1. allow customizing which keys are registered
  -- 2. expose the callback function, allowing user defined callbacks
  setup_autocmds()

  -- Save important keybinds in <plug> bindings, for reuse
  for _, key in ipairs({ ";", ",", "n", "<s-n>" }) do
    for _, mode in ipairs({ "n", "v" }) do
      vim.keymap.set(mode, "<plug>" .. key, key, {silent = true})
    end
  end

  for key, _ in pairs(mappings_table) do
    for _, mode in ipairs({ "n", "v" }) do
      register_key(mode, key)
    end
  end
end

return {
  setup = setup,
  n = n,
  shift_n = shift_n,
}
