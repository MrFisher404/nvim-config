local M = {}

function M.setup()
  local status_ok, neorg = pcall(require, "neorg")
  if not status_ok then
    return
  end
  neorg.setup {
          load = {
          ["core.defaults"] = {},
--          ["core.gtd.base"] = {},
          ["core.norg.concealer"] = {},
          ["core.norg.dirman"] = {},
					["core.norg.completion"] = { config = { engine = "nvim-cmp" } },
					["core.norg.dirman"] = {
							config = {
									workspaces = {
											work = "~/git_repos/zettelkasten/neorg/work",
											home = "~/git_repos/zettelkasten/neorg/home",
									},
									autochdir = false,
									index = "index.norg",
									default_workspace = "work"
							}
					},
				["core.gtd.base"] = {
						config = {
								workspace = "work",
						},
				}, 
          ["core.presenter"] = {
            config = {
              zen_mode = "truezen",
            },
          },
          },
        }
end

return M
