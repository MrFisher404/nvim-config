local M = {}
function M.setup()
  require("neorg").setup {
    load = {
      ["core.defaults"] = {},
      ["core.norg.dirman"] = {
        config = {
          workspaces = {
            work = "~/gitRepos/mrfisher404/notes/work",
            home = "~/gitRepos/mrfisher404/notes/home",
            planner = "~/gitRepos/mrfisher404/notes/gtd",
            journal = "~/gitRepos/mrfisher404/notes/journal",
          },
        },
      },
      ["core.gtd.base"] = {
        config = {
          workspace = "planner",
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
