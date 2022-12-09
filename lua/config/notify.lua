local M = {}

local icons = require "config.icons"

function M.setup()
  local notify = require "notify"
  notify.setup {
    icons = {
      ERROR = icons.diagnostics.Error,
      WARN = icons.diagnostics.Warning,
      INFO = icons.diagnostics.Information,
      DEBUG = icons.ui.Bug,
      TRACE = icons.ui.Pencil,
    },
    background_colour = "#000000"
  }
  vim.notify = notify
end

return M
