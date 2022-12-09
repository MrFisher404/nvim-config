local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  local function header()
    return {

      [[   ,o888b,`?88888                                  __                  88888P',d888o,   ]],
      [[ ,8888 888   ?888     ___     ___    ___   __  __ /\_\    ___ ___      888P   888 8888, ]],
      [[ 8888888P'    888    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\    888    `?8888888 ]],
      [[ 888P'        888   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \   888        `?888 ]],
      [[ `88   O     d888   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\  888b     O   88' ]],
      [[   `?._  _.o88888    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/  88888o._  _.P'   ]],
    }
  end

  dashboard.section.header.val = header()

  dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", "<cmd>lua require('telescope.builtin').find_files({cwd = '/home/$USER/.config/nvim/'}) <CR>"),
    dashboard.button("p", "  Projects", "<cmd>Telescope projects<CR>"),
    dashboard.button("k", "  Kitty", ":e /home/$USER/.config/kitty/kitty.conf<CR>"),
    dashboard.button("i", "  i3", ":e /home/$USER/.config/i3/config<CR>"),
    dashboard.button("z", "  zsh", ":e /home/$USER/.zshrc<CR>"),
    dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y  %H:%M:%S"
    local plugins_text = "\t" .. total_plugins .. " plugins  " .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"
  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
