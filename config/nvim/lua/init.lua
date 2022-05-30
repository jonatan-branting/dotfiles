require("modules.core_settings")
require("modules.mappings")

require("modules.dap")
require("modules.cmp")
require("modules._lsp")
require("modules.bqf")
require("modules.gitsigns")
require("modules.notifications")
require("modules.treesitter")
require("modules._telescope")
require("modules.neogit")
require("modules.autopairs")
require("modules.colorscheme")
require("modules._todo")
require("modules._feline")
require("modules.neorg")
require("modules.possession")
require("modules.diagnostics")

require("modules.popup").setup()

require("pqf").setup()
require("dd").setup()
require("trouble").setup()
require("dressing").setup()

require("modules.better_n").setup {
  callbacks = {
    mapping_executed = function(_, key)
      if key == "n" then return end

      -- Clear highlighting, indicating that `n` will not goto the next
      -- highlighted search-term
      vim.cmd [[ nohl ]]
    end
  },
  mappings = {
    ["<leader>hn"] = {previous = "<leader>hp", next = "<leader>hn"},
    ["<leader>hp"] = {previous = "<leader>hp", next = "<leader>hn"},

    ["<leader>bn"] = {previous = "<leader>bp", next = "<leader>bn"},
    ["<leader>bp"] = {previous = "<leader>bp", next = "<leader>bn"},

    ["<c-d>"] = {previous = "<c-u>", next = "<c-d>"},
    ["<c-u>"] = {previous = "<c-u>", next = "<c-d>"},
  }
}

require("better_escape").setup {
  mapping = {"jk", "jj"},
  timeout = vim.o.timeoutlen,
  clear_empty_lines = false,
  keys = "<Esc>",
}

require("goto-preview").setup {
  width = 120,
  height = 15,
  border = {" ", "─" ,"┐", "│", "┘", "─", "└", "│"},
  default_mappings = false,
  debug = false,
  opacity = nil,
  resizing_mappings = false,
  post_open_hook = nil,
  focus_on_open = true,
  dismiss_on_move = false,
}

require("git-worktree").setup({
  update_on_change = true,
  clearjumps_on_change = true
})

require("nvim-ts-autotag").setup({
  enabled = true,
  filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue", "eruby", "erb" },
})

require("notify").setup({
  stages = "static",
  max_width = 50,
  render = "minimal"
})

vim.notify = require("notify")
