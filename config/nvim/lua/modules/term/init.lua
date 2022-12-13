local Handler = require("modules.term.handler")

local M = {}

setmetatable(M, {
  __index = function(_, key)
    return _G.term_handler[key]
  end,
})

function M.setup()
  _G.term_handler = Handler:new()
end


-- require("modules.term").setup()
-- vim.keymap.set("n", "<leader>x", require("modules.term.handler").last_terminal():send("ls"))
-- vim.keymap.set("n", "<leader>l", require("modules.term.handler").last_terminal():toggle("ls"))

-- require("modules.term").setup()
-- vim.keymap.set("n", "<leader>l", function ()
--   require("modules.term").handler.last_terminal().toggle()
-- end)

return M
