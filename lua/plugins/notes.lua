return {
  {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- custom config that will be executed when loading the plugin
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                work = "~/notes/work",
                home = "~/notes/home",
                planner = "~/notes/planner",
              },
            },
          },
        },
      })
    end,
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    name = "omnisharp-extended",
  },
}
