local npairs = require('nvim-autopairs')

npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  check_ts = true,
  break_undo = false,
  map_bs = true,
  map_c_w = true,
  fast_wrap = {
    map = "<M-e>"
  },
  enable_afterquote = true,
  enable_moveright = true,
  enable_check_bracket_line = true,
  ts_config = {
  }
})

local Rule = require'nvim-autopairs.rule'

local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end

for _,punct in pairs { ",", ";" } do
  require "nvim-autopairs".add_rules {
    require "nvim-autopairs.rule"("", punct)
      :with_move(function(opts) return opts.char == punct end)
      :with_pair(function() return false end)
      :with_del(function() return false end)
      :with_cr(function() return false end)
      :use_key(punct)
  }
end
