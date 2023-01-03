local M = {}

local util = require "util"

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    util.info("enabled format on save", "Formatting")
  else
    util.warn("disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    vim.lsp.buf.formatting_sync(nil, 2000)
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")

  if client.server_capabilities.document_formatting then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.lsp.formatting").format()
      augroup END
    ]]
  end
end

return M
