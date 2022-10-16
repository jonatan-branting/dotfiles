local none = "none"

local utils = require("modules.ui.utils")

vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "fern" }
vim.g.tokyonight_style = "night"
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_float = true
vim.g.catppuccin_flavour = "mocha"

require("catppuccin").setup({
  term_colors = true,
})

vim.cmd [[ set bg=dark ]]
vim.cmd [[ colorscheme catppuccin]]

local function highlight(group, opts)
  local options = ""
  for k, v in pairs(opts) do
    options = options .. " " .. k .. "=" .. v
  end

  vim.cmd("hi " .. group .. options)
end

highlight("MatchParen", { guibg = utils.darken("#c0caf5", 0.10) , guifg=none, gui=none})
highlight("SignColumn", { guibg = none })
highlight("LineNr", { guibg = none })

vim.cmd [[ highlight! link TelescopeMatching IncSearch ]]
vim.cmd [[ highlight! link FidgetTask Pmenu ]]
vim.cmd [[ highlight! link MiniIndentscopeSymbol Comment ]]
vim.cmd [[ highlight! link FloatBorder Pmenu ]]
vim.cmd [[ highlight! link MiniTrailspace CursorLine ]]
vim.cmd [[ highlight! link Telescope CursorLine ]]
vim.cmd [[ highlight! link TelescopeBorder FloatBorder]]
vim.cmd [[ highlight! link TelescopeNormal NormalFloat]]
vim.cmd [[ highlight! link TelescopeSelection Visual]]
vim.cmd [[ highlight! link TelescopeNormal NormalFloat]]

local normal = utils.get_highlight("Normal")
local bg = utils.lighten(normal.bg, 0.90, normal.fg)
local fg = normal.fg
local settings = {guibg=bg, guifg=normal.fg}
highlight("NormalFloat", settings)
highlight("FloatNormal", settings)
highlight("FloatBorder", { guibg=bg, guifg=bg})

local prompt_bg = utils.lighten(bg, 0.85, fg)
highlight("TelescopePromptNormal", {guibg=prompt_bg, guifg=fg})
highlight("TelescopePromptBorder", {guibg=prompt_bg, guifg=fg})
highlight("TelescopePromptTitle", {guibg=prompt_bg, guifg=prompt_bg})

local border_fg = utils.darken("#c0caf5", 0.20)
highlight("VertSplit", { guifg = border_fg, guibg = none })

highlight("StatuslineNC", { guibg = none, guifg = none, gui = none })
highlight("VertSplit", { guibg = "bg" })

vim.cmd [[
  hi link DiagnosticVirtualTextError DiagnosticSignError
  hi link DiagnosticVirtualTextHint DiagnosticSignHint
  hi link DiagnosticVirtualTextWarn DiagnosticSignWarn
  hi link DiagnosticVirtualTextInfo DiagnosticSignInfo
]]
