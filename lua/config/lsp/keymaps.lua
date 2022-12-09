local M = {}

local whichkey = require "which-key"

local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  buf_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)

  -- Whichkey
  local keymap_l = {
    l = {
      name = "Code",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line Diagnostics" },
      c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor Diagnostics" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Formatting" },
    },
  }
  if client.server_capabilities.document_formatting then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  end

  whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M
