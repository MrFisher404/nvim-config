local M = {}

local windows = require("utils.windows")

M.todo = function ()
  windows.open_win()
  vim.cmd("e ~/notes/todo.norg")
end

M.new_note = function ()
  -- get the current time
  local current_time = os.time()
  -- convert the current time to a timestamp string
  local timestamp = os.date("%Y-%m-%d %H:%M:%S", current_time)
  windows.open_win()
  vim.cmd("e ~/notes/"..timestamp..".norg")
end

return M
