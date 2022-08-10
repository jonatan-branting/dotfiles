local M = {}
local ts_utils = require("nvim-treesitter.ts_utils")

function M.get_node_at_position(buf, ignore_injected_langs, col, row)
  local root_lang_tree = vim.treesitter.get_parser(buf)
  if not root_lang_tree then
    return
  end

  local root
  if ignore_injected_langs then
    for _, tree in ipairs(root_lang_tree:trees()) do
      local tree_root = tree:root()
      if tree_root and ts_utils.is_in_node_range(tree_root, col, row) then
        root = tree_root
        break
      end
    end
  else
    root = ts_utils.get_root_for_position(col, row, root_lang_tree)
  end

  if not root then
    return
  end

  return root:named_descendant_for_range(col, row, col, row)
end

return M
