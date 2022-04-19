-- local colors = require("tokyonight.colors").setup()

local dark_background = "#0d0d0d"
local bg_float = "#1f2335"
local none = "none"
local border_color = "#303030"

-- Plugin settings
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "fern" }
vim.g.moonflyNormalFloat = 1
vim.g.moonflyUnderlineMatchParen = 1
-- vim.g.tokyonight_style = "day"
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_colors = {
  bg_dark = bg_float,
  bg = "#2C3148"
}

-- vim.g.gruvbox_flat_style = "hard"
vim.g.gruvbox_dark_float = true
-- vim.g.gruvbox_dark_float = true
vim.cmd [[ colorscheme moonfly ]]
vim.cmd [[ set bg=dark ]]

function highlight(group, opts)
  local options = ""
  for k, v in pairs(opts) do
    options = options .. " " .. k .. "=" .. v
  end

  vim.cmd("hi " .. group .. options)
end

highlight("SignColumn", { guibg = none })
highlight("LineNr", { guibg = none })
-- highlight("VertSplit", { guifg = colors.fg_gutter })

highlight("TelescopeBorder", { guibg = dark_background })
highlight("TelescopePreviewBorder", { guibg = none, guifg = "#c0caf5" })
highlight("TelescopeNormal", { guibg = dark_background })
highlight("TelescopePromptBorder", { guibg = dark_background})
highlight("TelescopePromptNormal", { guibg = dark_background})
highlight("TelescopeResultsBorder", { guibg = dark_background })
vim.cmd [[
  highlight link TelescopeMatching IncSearch
]]

highlight("NormalFloat", { guibg=dark_background})
highlight("FloatBorder", { guifg=border_color, guibg=dark_background})
highlight("StatuslineNC", { guibg = none, guifg = none, gui = none })
highlight("VertSplit", { guibg = "bg" })

-- highlight("NotifyWARNBorder", { guifg = none })
-- highlight("NotifyERRORBorder", { guifg = none })
-- highlight("NotifyDEBUGBorder", { guifg = none })
-- highlight("NotifyTRACEBorder", { guifg = none })
-- highlight("NotifyINFOBorder", { guifg = none })

-- highlight("NotifyWARNBody", { guibg = "#e3c78a"})
-- highlight("NotifyERRORBody", { guibg = "#ff5454" })
-- highlight("NotifyDEBUGBody", { guibg = "#36c692" })
-- highlight("NotifyTRACEBody", { guibg = "#c6c6c6" })
-- highlight("NotifyINFOBody", { guibg = "#e4e4e4" })

vim.api.nvim_exec([[set fillchars+=vert:\|]], false) -- How do I do this using lua?

-- highlight("ALEError", { guisp = colors.error, gui = "undercurl"})
-- highlight("ALEVirtualTextError", { guibg = colors.error })
-- highlight("ALEErrorSign", { guibg = colors.error })
-- highlight("ALEErrorSignLineNr", { guibg = colors.error })
-- highlight("ALEWarning", { guisp = colors.warning, gui = "undercurl"})
-- highlight("ALEVirtualTextWarning", { guibg = colors.warning, guifg=colors.bg_highlight })
-- highlight("ALEWarningSign", { guifg = colors.warning})
-- highlight("ALEWarningSignNr", { guibg = colors.warning, gui=reverse })
-- highlight("ALEInfo", { guibg = colors.info})
-- highlight("ALEInfoSign", { guifg = colors.info})
-- highlight("ALEInfoSignNr", { guibg = colors.info})
-- highlight("ALEInfo", { guisp = colors.info, gui = "undercurl"})
-- highlight("ALEVirtualTextInfo", { guibg = colors.info})

-- highlight("ALEStyleError", { guifg = colors.error })
-- highlight("ALEVirtualTextStyleError", { guifg = colors.error })
-- highlight("ALEStyleErrorSign", { guifg = colors.error })
-- highlight("ALEStyleErrorSignNr", { guifg = colors.error })

-- highlight("ALEStyleWarning", { guifg = colors.warning })
-- highlight("ALEVirtualTextStyleWarning", { guifg = colors.warning })
-- highlight("ALEStyleWarningSign", { guifg = colors.warning })
-- highlight("ALEStyleWarningSignNr", { guifg = colors.warning })

-- highlight("FloatBorder", { guifg = border_color })
-- highlight("WhichKeyFloat", { guibg = bg_float })
-- highlight("GitSignsCurrentLineBlame", { guifg = "#88929c" })
highlight("FZFNormal", { guibg=dark_background })

-- require("lsp-colors").setup({
--   Error = "#db4b4b",
--   Warning = "#e0af68",
--   Information = "#0db9d7",
--   Hint = "#10B981"
-- })
