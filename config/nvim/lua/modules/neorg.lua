require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes/",
        }
      }
    },
    ["core.norg.journal"] = {
      config = {}
    },
  }
}

