local M = {}

local overseer = require("overseer")

function M.setup()
  overseer.setup({
    templates = {
      "builtin",
      --"work",
      "user.cpp_build" },
  })
end

return M
