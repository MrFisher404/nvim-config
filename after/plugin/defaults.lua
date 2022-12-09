-- local api = vim.api
local g = vim.g
local opt = vim.opt
-- local cmd = vim.cmd

local is_wsl = (function()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end)()

-- Remap leader and local leader to <Space>
-- api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = ","
g.vimsyn_embed = "lPr" -- Syntax embedding for Lua, Python and Ruby

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
--opt.clipboard = "unnamedplus" -- Access system clipboard
opt.listchars:append "eol:↴" -- used for inden-blankline plugin

--if is_wsl then
--  g.clipboard = {
--    name = "win32yank-wsl",
--    copy = {
--      ["+"] = "win32yank.exe -i --crlf",
--      ["*"] = "win32yank.exe -i --crlf"
--    },
--    paste = {
--      ["+"] = "win32yank.exe -o --crlf",
--      ["*"] = "win32yank.exe -o --crlf"
--    },
--    cache_enable = 0,
--  }
--end
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
-- opt.scrolloff = 999 -- Lines of context
-- opt.sidescrolloff = 999
opt.joinspaces = false -- No double spaces with join after a dot
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal"
opt.smartindent = true --Smart indent
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 0
opt.autoindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 2
opt.pumheight = 15
opt.backspace = "indent,eol,start"
opt.fillchars = { diff = "/"}




-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
