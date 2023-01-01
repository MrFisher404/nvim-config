local M = {}

local whichkey = require "which-key"
local next = next

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>lua require('utils').quit()<CR>", "Quit" },

    --a = {
    --  name = "Attempt",
    --  n = { "<Cmd>lua require('attempt').new_select()<Cr>", "New Select" },
    --  i = { "<Cmd>lua require('attempt').new_input_ext()<Cr>", "New Input Extension" },
    --  r = { "<Cmd>lua require('attempt').run()<Cr>", "Run" },
    --  d = { "<Cmd>lua require('attempt').delete_buf()<Cr>", "Delete Buffer" },
    --  c = { "<Cmd>lua require('attempt').rename_buf()<Cr>", "Rename Buffer" },
    --  s = { "<Cmd>Telescope attempt<Cr>", "Search" },
    --},

    b = {
      name = "Buffer",
      c = { "<Cmd>bdelete<Cr>", "Close Buffer" },
      x = { "<Cmd>bdelete!<Cr>", "Force Close Buffer" },
      b = { "<Cmd>BufferLinePick<Cr>", "Pick a Buffer" },
      p = { "<Cmd>BufferLinePickClose<Cr>", "Pick & Close a Buffer" },
      f = { "<Cmd>JABSOpen<Cr>", "Find" },
    },

    c = {
      name = "Code Doc",
      g = { "<cmd>Neogen func<Cr>", "Func Doc" },
      G = { "<cmd>Neogen class<Cr>", "Class Doc" },
      d = { "<cmd>DogeGenerate<Cr>", "Generate Doc" },
    },

    d = {
      name = "Debug",
      R = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
      E = { "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", "Evaluate Input" },
      C = { "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", "Conditional Breakpoint" },
      U = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
      c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
      d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
      g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
      h = { "<cmd>lua require'dap.ui.widgets'.hover()<cr>", "Hover Variables" },
      S = { "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", "Scopes" },
      i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
      o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
      p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
      q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
      r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
      s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
      t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      x = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
      u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    },

    x = {
      name = "Xplore",
      d = { "<cmd>Neotree source=filesystem position=float toggle<Cr>", "Float" },
      j = { "<cmd>Neotree source=filesystem position=bottom toggle<Cr>", "Bottom" },
      h = { "<cmd>Neotree source=filesystem position=left toggle<Cr>", "Left" },
      k = { "<cmd>Neotree source=filesystem position=top toggle<Cr>", "Top" },
      l = { "<cmd>Neotree source=filesystem position=right toggle<Cr>", "Right" },
      b = { "<cmd>Neotree source=buffers position=right toggle<Cr>", "Buffers" },
      g = { "<cmd>Neotree source=git_status position=left toggle<Cr>", "Git Status" },
    },

    e = {
      name = "Error/Diagnostics",
      r = { "<cmd>TroubleRefresh<Cr>", "Refresh" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<Cr>", "Workspace" },
      e = { "<cmd>Neotree diagnostics toggle bottom<Cr>", "Errors" },
      l = { "<cmd>TroubleToggle document_diagnostics<Cr>", "Local" },
      j = { "<cmd>Lspsaga diagnostic_jump_next<Cr>", "Next" },
      k = { "<cmd>Lspsaga diagnostic_jump_prev<Cr>", "Previous" },
    },

    f = {
      name = "Find",
      a = { "<cmd>Alpha<cr>", "Alpha" },
      f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
      d = { "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>", "Definition" }, -- Todo make this only for omnisharp else normal telescope_lsp_definitions
      b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
      m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
      o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
      i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
      u = { "<cmd>lua require('telescope.builtin').lsp_references({include_declaration = false})<cr>", "Usages" },
      s = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "String Live Grep" },
      c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
      w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
      l = { "<cmd>Telescope file_browser path=%:p:h hidden=true<cr>", "Local File Browser" },
      e = { "<cmd>NvimTreeFindFileToggle<cr>", "Explorer" },
    },
    p = {
      name = "Project",
      p = { "<cmd>lua require'telescope'.extensions.project.project{display_type = 'full'}<cr>", "List" },
      s = { "<cmd>lua require'telescope'.extensions.repo.list{}<cr>", "Search" },
      P = { "<cmd>TermExec cmd='BROWSER=brave yarn dev'<cr>", "Slidev" },
    },

    j = {
      name = "Jump",
      a = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
      m = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
      c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
    },

    m = {
      name = "ModeZen",
      f = { "<cmd>TZFocus<cr>", "Focus" },
      a = { "<cmd>TZAtaraxis<cr>", "Ataraxis" },
      m = { "<cmd>TZMinimalist<cr>", "Minimalist" },
    },

    ["0"] = { "<cmd>lua require('utils.term').term_toggle()<CR>", "Terminal" },
    ["1"] = { "<Cmd>lua require('harpoon.ui').nav_file(1) <Cr>", "File 1" },
    ["2"] = { "<Cmd>lua require('harpoon.ui').nav_file(2) <Cr>", "File 2" },
    ["3"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(1)<Cr>", "Terminal 1" },
    ["4"] = { "<Cmd>lua require('harpoon.term').gotoTerminal(2)<Cr>", "Terminal 2" },
    ["5"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,1)<Cr>", "Command 1" },
    ["6"] = { "<Cmd>lua require('harpoon.term').sendCommand(1,2)<Cr>", "Command 2" },

    t = {
      name = "Test",
      a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach" },
      f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run File" },
      F = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Debug File" },
      l = { "<cmd>lua require('neotest').run.run_last()<cr>", "Run Last" },
      L = { "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", "Debug Last" },
      n = { "<cmd>lua require('neotest').run.run()<cr>", "Run Nearest" },
      N = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Debug Nearest" },
      o = { "<cmd>lua require('neotest').output.open({ enter = true })<cr>", "Output" },
      S = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop" },
      s = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Summary" },
      j = { "<cmd>lua require('neotest').jump.next({ status = 'failed' }", "Next Failed" },
      k = { "<cmd>lua require('neotest').jump.prev({ status = 'failed' }", "Prev Failed" },
      p = { "<Plug>PlenaryTestFile", "PlenaryTestFile" },
      v = { "<cmd>TestVisit<cr>", "Visit" },
      x = { "<cmd>TestSuite<cr>", "Suite" },
    },


    n = {
      name = "Neorg",
      c = { "<cmd>Neorg gtd capture<cr>", "Capture" },
      u = { "<cmd>Neorg news<cr>", "Updates" },
      d = { "<cmd>Neorg journal<cr>", "Diary" },
      t = { "<cmd>lua require('config.notes').todo()<cr>", "Todo" }
    },

    z = {
      name = "System",
      e = { "!!$SHELL<CR>", "Execute line" },
      o = { "<cmd>lua require'telescope'.extensions.zoxide.list{}<cr>", "Zoxide" },
      z = { "<cmd>NoNeckPain<cr>", "Zoxide" },
    },
    o = {
      name = "Open",
      f = { "<cmd>ToggleTerm direction=float <Cr>", "Terminal Float" },
      l = { "<cmd>ToggleTerm direction=float dir=%<Cr>", "Terminal Local" },
      h = { "<cmd>ToggleTerm direction=horizontal size=15<Cr>", "Terminal Horizontal" },
      v = { "<cmd>ToggleTerm direction=vertical size=80<Cr>", "Terminal Vertical" },
      t = { "<cmd>TSPlaygroundToggle<Cr>", "TSPlayGround" },
    },

    g = {
      name = "Git",
      b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Blame" },
      g = { "<cmd>lua require('utils.term').git_client_toggle()<CR>", "Git TUI" },
      d = { "<cmd>DiffviewOpen<CR>", "Diff" },
      c = { "<cmd>DiffviewClose<CR>", "Close" },
      h = { "<cmd>DiffviewToggleFiles<CR>", "Toggel Panel" },
      j = { "<cmd>Gitsigns prev_hunk<CR>", "Prev Hunk" },
      k = { "<cmd>Gitsigns next_hunk<CR>", "Next Hunk" },
      u = { "<cmd>Gitsigns reset_hunk<CR>", "Reset Hunk" },
      p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview Hunk" },
    },
  }
  whichkey.register(keymap, opts)
end

local function visual_keymap()
  local keymap = {
    m = {
      name = "ModeZen",
      n = { "<cmd>TZNarrow<cr>", "Narrow" },
    },

    r = {
      name = "Refactor",
      e = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
      f = {
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>]],
        "Extract Function to File",
      },
      v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
      i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
      r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
      V = { [[ <Esc><Cmd>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
  local keymap = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },

    d = {
      name = "Debug",
      e = { "<cmd>lua require'dapui'.eval()<cr>", "Evaluate" },
    },

    r = {
      name = "Refactor",
      e = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], "Extract Function" },
      f = {
        [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>]],
        "Extract Function to File",
      },
      v = { [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], "Extract Variable" },
      i = { [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], "Inline Variable" },
      r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
      V = { [[ <Esc><Cmd>lua require('refactoring').debug.print_var({})<CR>]], "Debug Print Var" },
    },
  }

  whichkey.register(keymap, v_opts)
end

local function code_keymap()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.schedule(CodeRunner)
    end,
  })

  function CodeRunner()
    local bufnr = vim.api.nvim_get_current_buf()
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local fname = vim.fn.expand "%:p:t"
    local keymap_c = {} -- normal key map
    local keymap_c_v = {} -- visual key map

    if ft == "python" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
        m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
      }
    elseif ft == "lua" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>luafile %<cr>", "Run" },
      }
    elseif ft == "rust" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>execute 'Cargo run' | startinsert<cr>", "Run" },
        D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
        h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
        R = { "<cmd>RustRunnables<cr>", "Runnables" },
      }
    elseif ft == "go" then
      keymap_c = {
        name = "Code",
        r = { "<cmd>GoRun<cr>", "Run" },
      }
    elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
        r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
        i = { "<cmd>TypescriptAddMissingImports<cr>", "Import Missing" },
        F = { "<cmd>TypescriptFixAll<cr>", "Fix All" },
        u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused" },
        R = { "<cmd>lua require('config.test').javascript_runner()<cr>", "Choose Test Runner" },
        s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
        t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
      }
    elseif ft == "java" then
      keymap_c = {
        name = "Code",
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
        v = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
        t = { "<cmd>lua require('jdtls').test_class()<cr>", "Test Class" },
        n = { "<cmd>lua require('jdtls').test_nearest_method()<cr>", "Test Nearest Method" },
      }
      keymap_c_v = {
        name = "Code",
        v = { "<cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        c = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
      }
    end

    if fname == "package.json" then
      keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
      keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
      keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
      keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
    end

    if fname == "Cargo.toml" then
      keymap_c.u = { "<cmd>lua require('crates').upgrade_all_crates()<cr>", "Upgrade All Crates" }
    end

    if next(keymap_c) ~= nil then
      local k = { c = keymap_c }
      local o = { mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
    end

    if next(keymap_c_v) ~= nil then
      local k = { c = keymap_c_v }
      local o = { mode = "v", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>", nowait = true }
      whichkey.register(k, o)
    end
  end
end

function M.setup()
  normal_keymap()
  visual_keymap()
  code_keymap()
end

return M
