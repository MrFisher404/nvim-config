local M = {}

local windows = require("utils.windows")

M.todo = function ()
  windows.open_win()
  vim.cmd("e ~/notes/todo.norg")
end

return M
