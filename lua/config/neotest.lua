local M = {}

function M.setup()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "unittest",
      },
      require "neotest-jest",
      require "neotest-plenary",
      require "neotest-dotnet",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "cs"},
      },
    },
		icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",
				passed = "",
				running = "",
				failed = "",
				unknown = "",
				skipped = ""
		},
    consumers = {
      --overseer = require("neotest.consumers.overseer"),
    },
  }
end

return M
