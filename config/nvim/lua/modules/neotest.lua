require("neotest").setup({
  icons = {
    expanded = "",
    child_prefix = "",
    child_indent = "",
    final_child_prefix = "",
    non_collapsible = "",
    collapsed = "",

    passed = "",
    running = "",
    failed = "",
    unknown = ""
  },
  status = {
    signs = false,
    enabled = true,
    virtual_text = true,
  },
  output = {
  },
  consumers = {
    function(client)
    end
  },
  adapters = {
    require("neotest-python")({
      dap = {  },
    }),
    require("neotest-plenary"),
    require("neotest-rspec"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})
