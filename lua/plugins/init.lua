return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  --
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      multiwindow = false, -- Enable multiwindow support.
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
    }
  },

  { "nvzone/volt" , lazy = true },
  { "nvzone/menu" , lazy = true },

  {
    'Bekaboo/dropbar.nvim',
    lazy = false,
  },

  -- SUGGESTION
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        event = { "InsertEnter", "BufEnter", "BufRead" , "LspAttach" },
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = function()
      require "configs.nvim-cmp"
    end,
  },
  -- SUGGESTION

  -- COPILOT
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    branch = "canary",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        lazy = false,
        event = { "InsertEnter", "BufEnter", "BufRead" },
        config = function()
          require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      show_help = true, -- Show help actions
      window = {
        layout = 'float',
        relative = 'cursor',
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        width = 0.4,
        height = 0.6,
        row = 1
      }
    },
  },
  -- COPILOT

  -- FLUTTER
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function()
      require "configs.flutter-tools"
    end,
  },
  -- FLUTTER

  {
    'lewis6991/satellite.nvim',
    lazy = false,
    opts = function()
      require('satellite').setup {
        winblend = 50,
        zindex = 40,
        handlers = {
          cursor = {
            enable = true,
            symbols = { '█' }
            -- Highlights:
            -- - SatelliteCursor (default links to NonText
          },
          search = {
            enable = true,
            symbols = { '▕', '▕' }
            -- Highlights:
            -- - SatelliteSearch (default links to Search)
            -- - SatelliteSearchCurrent (default links to SearchCurrent)
          },
          diagnostic = {
            enable = true,
            -- signs = {'-', '=', '≡'},
            signs = { '￭', '￭', '￭', '￭' },
            min_severity = vim.diagnostic.severity.HINT,
            -- Highlights:
            -- - SatelliteDiagnosticError (default links to DiagnosticError)
            -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
            -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
            -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
          },
        }
      }
    end,
  }
}
