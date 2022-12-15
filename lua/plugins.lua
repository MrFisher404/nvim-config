local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },

    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

--#########################
-- Little features -----------
--#########################

-- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require("config.notify").setup()
      end,
    }

-- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

-- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        require("config.whichkey").setup()
      end,
    }

-- See Color
    use { "norcalli/nvim-colorizer.lua" }


--#########################
-- Appearance ------------
--#########################


-- Icons
    use { "onsails/lspkind.nvim" }
-- Coloschemes
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup()
        vim.cmd [[colorscheme catppuccin]]
      end,
      disable = true,
    }

    use {
      "sainnhe/gruvbox-material",
      config = function()
        vim.cmd [[colorscheme gruvbox-material]]
      end,
      disable = true,
    }

    use {
       "ellisonleao/gruvbox.nvim",
      config = function()
        require("config.gruvbox").setup()
      end,
      disable = false,
    }

		--use {
    --  opt = true,
		--	"ziontee113/color-picker.nvim",
		--	config = function()
		--			require("config.colorpicker").setup()
		--	end,
    --  event = "PickColor",
    --  disable = false,
		--}


-- Better icons
    use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

-- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      after = "nvim-treesitter",
      config = function()
        require("config.lualine").setup()
      end,
      wants = "nvim-web-devicons",
    }

-- Make IndentLines better visible 
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }


--#########################
-- Git -----------
--#########################
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }

    use {
      'TimUntersberger/neogit',
      requires = 'nvim-lua/plenary.nvim'
    }
    -- Diffview
    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
      config = function ()
        require("config.diffview").setup()
      end
    }

--#########################
-- Notes ------------------
--#########################
    use {
      "iamcco/markdown-preview.nvim",
      opt = true,
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
      requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    }

    -- Zk integration (zetttelkasten cli)
    use
    {
      "mickael-menu/zk-nvim",
      config = function ()
        require("config.zk").setup()
      end

    }


--#########################
-- Treesitter -------------
--#########################
    use {
      "nvim-treesitter/nvim-treesitter",
      --opt = true,
      --event = "BufReadPre",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        -- { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
        -- { "yioneko/nvim-yati", event = "BufReadPre" },
      },
    }

    use { "nvim-treesitter/playground" }


--#########################
-- Telescope -------------
--#########################

    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("config.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      keys = { "<leader>f", "<leader>p", "<leader>z" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "project.nvim",
        -- "vim-rooter",
        "trouble.nvim",
        "telescope-dap.nvim",
        "telescope-frecency.nvim",
        "nvim-neoclip.lua",
        "telescope-smart-history.nvim",
        "telescope-arecibo.nvim",
        "telescope-media-files.nvim",
        "telescope-github.nvim",
        "telescope-zoxide",
        "cder.nvim",
        -- "telescope-ui-select.nvim",
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
        -- {
        --   "airblade/vim-rooter",
        --   config = function()
        --     require("config.rooter").setup()
        --   end,
        -- },
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("config.project").setup()
          end,
        },
        "nvim-telescope/telescope-dap.nvim",
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
            -- config = function()
            --   require("neoclip").setup()
            -- end,
          },
        },
        "nvim-telescope/telescope-smart-history.nvim",
        {
          "nvim-telescope/telescope-arecibo.nvim",
          rocks = { "openssl", "lua-http-parser" },
        },
        "nvim-telescope/telescope-media-files.nvim",
        "dhruvmanila/telescope-bookmarks.nvim",
        "nvim-telescope/telescope-github.nvim",
        "jvgrootveld/telescope-zoxide",
        "Zane-/cder.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
      },
    }


--#########################
-- Navigation -------------
--#########################

-- Local Overview
    use {
		"ziontee113/neo-minimap",
		config = function()
			require("config.minimap").setup()
		end
		}

-- FileExplorer
    use {
      "nvim-neo-tree/neo-tree.nvim",
      --opt = true,
      branch = "v2.x",
      requires = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function()
        require("config.neotree").setup()
      end,
    }
    use {
      "mrbjarksen/neo-tree-diagnostics.nvim",
      requires = "nvim-neo-tree/neo-tree.nvim",
      module = "neo-tree.sources.diagnostics"
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      keys = { [[<leader>j]] },
      module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
      wants = { "telescope.nvim" },
      config = function()
        require("config.harpoon").setup()
      end,
    }

    -- Buffer
    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }


-- BufferPicker
    use {
      "matbme/JABS.nvim",
      cmd = "JABSOpen",
      config = function()
        require("config.jabs").setup()
      end,
      disable = false,
    }
    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = false,
    }

-- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      wants = "nvim-treesitter",
      event = "InsertEnter",
      disable = false,
    }

--#########################
-- LSP -----------
--#########################
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "mason-tool-installer.nvim",
        "cmp-nvim-lsp",
        "neodev.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
        "typescript.nvim",
        "nvim-navic",
      },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        "b0o/schemastore.nvim",
        "jose-elias-alvarez/typescript.nvim",
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
        },
      },
    }
    -- .NET / C#
    use { "Hoffs/omnisharp-extended-lsp.nvim" }
    use("J0rgeSerran0/vscode-csharp-snippets")
    use { "jlcrochet/vim-razor" }

    use { 'Issafalcon/lsp-overloads.nvim' }
		use({
			"folke/noice.nvim",
			config = function()
				require("noice").setup()
			end,
			requires = {
				-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
				"MunifTanjim/nui.nvim",
				-- OPTIONAL:
				--   `nvim-notify` is only needed, if you want to use the notification view.
				--   If not available, we use `mini` as the fallback
				"rcarriga/nvim-notify",
				}
		})

--#########################
-- Completion -----------
--#########################
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        { "onsails/lspkind-nvim", module = { "lspkind"  }  },
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("config.snip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      },
    }

    use { "ii14/emmylua-nvim" } -- better neovim api completion

    use {  'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter'  },
      config = function ()
        require('hlargs').setup()
      end
    }

    -- lspsaga.nvim
    use {
      "glepnir/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("lspsaga").init_lsp_saga()
      end,
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      -- event = "BufReadPre",
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
      requires = {
        "alpha2phi/DAPInstall.nvim",
        -- { "Pocco81/dap-buddy.nvim", branch = "dev" },
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }

    -- Test
   use {
      "nvim-neotest/neotest",
      requires = {
        {
          "vim-test/vim-test",
          event = { "BufReadPre" },
          config = function()
            require("config.test").setup()
          end,
        },
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "nvim-neotest/neotest-vim-test", module = { "neotest-vim-test" } },
        { "nvim-neotest/neotest-python", module = { "neotest-python" } },
        { "nvim-neotest/neotest-plenary", module = { "neotest-plenary" } },
        { "haydenmeade/neotest-jest", module = { "neotest-jest" } },
        { "Issafalcon/neotest-dotnet", module = { "neotest-dotnet" } },
      },
      module = { "neotest", "neotest.async" },
      config = function()
        require("config.neotest").setup()
      end,
      disable = false,
    }

    -- Code documentation
    use {
      "danymat/neogen",
      config = function()
        require("config.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen",
      disable = false,
    }

    --Zen
    use({
      "Pocco81/true-zen.nvim",
      config = function()
        require("true-zen").setup {
          -- your config goes here
          -- or just leave it empty :)
        }
      end,
      opt = true,
      cmd = { "TZAtarxis", "TZMinimalist", "TZNarrow", "TZFocus" }
    })


    -- Task runner
    use {
      "stevearc/overseer.nvim",
      opt = true,
      cmd = {
        "OverseerToggle",
        "OverseerOpen",
        "OverseerRun",
        "OverseerBuild",
        "OverseerClose",
        "OverseerLoadBundle",
        "OverseerSaveBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerQuickAction",
        "OverseerTaskAction",
      },
      config = function()
        require("config.overseer").setup()
      end,
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
