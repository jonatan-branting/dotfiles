local M = {}

function M.set_vim_test_strategy()
  local strategy_name = "term"

  vim.cmd [[
    function! TermStrategy(cmd) abort
      execute 'lua require("modules.term"):get_terminal():send("' . a:cmd . '")'
    endfunction

    let g:test#custom_strategies = { 'term': function('TermStrategy') }
  ]]

  vim.g["test#strategy"] = strategy_name

  return strategy_name
end

return M
