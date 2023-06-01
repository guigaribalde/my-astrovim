return {
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end,
    event = "User AstroFile"
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    enabled = true,
    cmd = "Oil",
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        buf_options = {
          buflisted = true,
          bufhidden = "delete",
        },
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        }
      })
    end,
  },
  -- {
  --   "dracula/vim",
  --   event = "VeryLazy"
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
  },
  {
    "sickill/vim-monokai",
    event = "VeryLazy",
  },
  {
    "patstockwell/vim-monokai-tasty",
    event = "VeryLazy",
  },
  {
    "joshdick/onedark.vim",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    event = "VeryLazy",
  },
  {
    "tomasr/molokai",
    event = "VeryLazy",
  },
  {
    "morhetz/gruvbox",
    event = "VeryLazy",
  },
  
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "storm", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(hl, c)
          local prompt = "#2d3149"
          hl.TelescopeNormal = {
            bg = c.bg_dark,
            fg = c.fg_dark,
          }
          hl.TelescopeBorder = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopePromptNormal = {
            bg = prompt,
          }
          hl.TelescopePromptBorder = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePromptTitle = {
            bg = prompt,
            fg = prompt,
          }
          hl.TelescopePreviewTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
          hl.TelescopeResultsTitle = {
            bg = c.bg_dark,
            fg = c.bg_dark,
          }
        end,
      })
    end,
    event = "VeryLazy"
  },
  {
    "Mofiqul/dracula.nvim",
    config = function()
      local dracula = require("dracula")
      dracula.setup({
        -- customize dracula color palette
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50fa7b",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
          bright_red = "#FF6E6E",
          bright_green = "#69FF94",
          bright_yellow = "#FFFFA5",
          bright_blue = "#D6ACFF",
          bright_magenta = "#FF92DF",
          bright_cyan = "#A4FFFF",
          bright_white = "#FFFFFF",
          menu = "#21222C",
          visual = "#3E4452",
          gutter_fg = "#4B5263",
          nontext = "#3B4048",
        },
        -- show the '~' characters after the end of buffers
        show_end_of_buffer = true, -- default false
        -- use transparent background
        -- transparent_bg = true, -- default false
        -- set custom lualine background color
        lualine_bg_color = "#44475a", -- default nil
        -- set italic comment
        italic_comment = true, -- default false
        -- overrides the default highlights see `:h synIDattr`
        -- overrides = {
        --   -- Examples
        --   -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        --   NvimTreeIndentMarker = { 
        --     bg = "#21222C",
        --   }, -- link to NonText highlight
        --   NeoTreeNormal = {
        --     bg = "#21222C",
        --   },
        --   NeoTreeNormalNC = {
        --     bg = "#21222C",
        --   },
        --   -- Nothing = {} -- clear highlight of Nothing
        -- },
      })
    end,
    event = "VeryLazy"
  },
  {
    "DaikyXendo/nvim-material-icon",
    opts = {},
    event = "VeryLazy"
  },
  {
    "theprimeagen/harpoon",
    opts = {},
    event = "VeryLazy"
  },
  {
    "github/copilot.vim",
    event = "VeryLazy"
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
    event = "VeryLazy"
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
    event = "User AstroFile"
  },
  {
    "easymotion/vim-easymotion",
    event = "User AstroFile"
  },
  {
    "kylechui/nvim-surround",
    opts = {},
    event = "User AstroFile"
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({})
    end,
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    event = "User AstroFile"
  }
}
