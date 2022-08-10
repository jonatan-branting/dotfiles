-- local colors = require("tokyonight.colors").setup()

local dark_background = "#0d0d0d"
local bg_float = "#1f2335"
local none = "none"
local border_color = "#303030"

local utils = require("modules.ui.utils")
local colors = require("tokyonight.colors").setup({
  style = "night",
}) -- pass in any of the config options as explained above

-- Plugin settings
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "fern" }
vim.g.tokyonight_style = "night"
vim.g.zenbones_darkness = "stark"
vim.g.zenbones_lightness = "bright"
vim.g.moonflyNormalFloat = 1
vim.g.moonflyUnderlineMatchParen = 1
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_float = true
-- vim.g.tokyonight_colors = {
--   bg_dark = bg_float,
--   bg = "#2C3148"
-- }

vim.g.everforest_background = "hard"
vim.cmd [[ set bg=dark ]] -- make this depend on mac?
vim.cmd [[ colorscheme tokyobones ]]

local function tester(group, opts)

  local options = ""
  local test = function()
    for k, v in pairs(opts) do

      options = options .. " " .. k .. "=" .. v
    end

    vim.cmd("hi " .. group .. options)
  end; local options = ""
end

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
local bg = utils.lighten(normal.bg, 0.95, normal.fg)
local fg = normal.fg
local settings = {guibg=bg, guifg=normal.fg}
highlight("NormalFloat", settings)
highlight("FloatNormal", settings)
highlight("FloatBorder", { guibg=bg, guifg=bg})

local prompt_bg = utils.lighten(bg, 0.9, fg)
highlight("TelescopePromptNormal", {guibg=prompt_bg, guifg=fg})
highlight("TelescopePromptBorder", {guibg=prompt_bg, guifg=fg})
highlight("TelescopePromptTitle", {guibg=prompt_bg, guifg=prompt_bg})
-- highlight("TelescopeBorder", {guibg=bg, guifg=bg})

local border_fg = utils.darken("#c0caf5", 0.20)
highlight("VertSplit", { guifg = border_fg, guibg = none })

-- `MiniIndentscopePrefix

-- highlight("NormalFloat", { guibg=dark_background})
-- highlight("FloatBorder", { guifg= border_fg, guibg = none })
-- highlight("NormalFloat", { guifg= "#c0caf5", guibg = none })
--
highlight("StatuslineNC", { guibg = none, guifg = none, gui = none })
highlight("VertSplit", { guibg = "bg" })

vim.cmd [[
  hi link DiagnosticVirtualTextError DiagnosticSignError
  hi link DiagnosticVirtualTextHint DiagnosticSignHint
  hi link DiagnosticVirtualTextWarn DiagnosticSignWarn
  hi link DiagnosticVirtualTextInfo DiagnosticSignInfo
]]

-- vim.api.nvim_exec([[set fillchars+=vert:\|]], false) -- How do I do this using lua?

highlight("FZFNormal", { guibg=dark_background })


local cmp_highlights = {
--     PmenuSel = { guibg = "#282C34", guifg = "NONE" },
--     Pmenu = { guifg = "#C5CDD9", guibg = "#22252A" },

--     CmpItemAbbrDeprecated = { guifg = "#7E8294", guibg = "NONE", gui = "strikethrough" },
--     CmpItemAbbrMatch = { guifg = "#82AAFF", guibg = "NONE", gui = "bold" },
--     CmpItemAbbrMatchFuzzy = { guifg = "#82AAFF", guibg = "NONE", gui = "bold" },
--     CmpItemMenu = { guifg = "#C792EA", guibg = "NONE", gui = "italic" },

    CmpItemKindField         = {  guifg = "#B5585F" },
    CmpItemKindProperty      = {  guifg = "#B5585F" },
    CmpItemKindEvent         = {  guifg = "#B5585F" },

    CmpItemKindText          = {  guifg = "#9FBD73" },
    CmpItemKindEnum          = {  guifg = "#9FBD73" },
    CmpItemKindKeyword       = {  guifg = "#9FBD73" },

    CmpItemKindConstant      = {  guifg = "#D4BB6C" },
    CmpItemKindConstructor   = {  guifg = "#D4BB6C" },
    CmpItemKindReference     = {  guifg = "#D4BB6C" },

    CmpItemKindFunction      = {  guifg = "#A377BF" },
    CmpItemKindStruct        = {  guifg = "#A377BF" },
    CmpItemKindClass         = {  guifg = "#A377BF" },
    CmpItemKindModule        = {  guifg = "#A377BF" },
    CmpItemKindOperator      = {  guifg = "#A377BF" },

    CmpItemKindVariable      = {  guifg = "#7E8294" },
    CmpItemKindFile          = {  guifg = "#7E8294" },

    CmpItemKindUnit          = {  guifg = "#D4A959" },
    CmpItemKindSnippet       = {  guifg = "#D4A959" },
    CmpItemKindFolder        = {  guifg = "#D4A959" },

    CmpItemKindMethod        = {  guifg = "#6C8ED4" },
    CmpItemKindValue         = {  guifg = "#6C8ED4" },
    CmpItemKindEnumMember    = {  guifg = "#6C8ED4" },

    CmpItemKindInterface     = {  guifg = "#58B5A8" },
    CmpItemKindColor         = {  guifg = "#58B5A8" },
    CmpItemKindTypeParameter = {  guifg = "#58B5A8" },
  }

-- for group, hi in pairs(cmp_highlights) do
--   highlight(group, hi)
-- end
