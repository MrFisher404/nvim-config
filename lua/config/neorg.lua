local M = {}
function M.setup()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "~/notes/work",
            home = "~/notes/home",
            planner = "~/notes/gtd",
            journal = "~/notes/journal",
          },
        },
      },
      ["core.norg.concealer"] = {
        config = { -- Note that this table is optional and doesn't need to be provided       -- Configuration here
        },
      },
    },
  }
end

return M
