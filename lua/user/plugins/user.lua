return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-live-grep-args.nvim" },
    opts = function() require("telescope").load_extension "live_grep_args" end,
  },
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
  -- {
  --   "folke/flash.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              -- ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              -- ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
              ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
              ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
              ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
              ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
              ["<leader>n:"] = "@property.outer",  -- swap object property with next
              ["<leader>nm"] = "@function.outer",  -- swap function with next
            },
            swap_previous = {
              ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
              ["<leader>p:"] = "@property.outer",  -- swap object property with prev
              ["<leader>pm"] = "@function.outer",  -- swap function with previous
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- vim way: ; goes to the direction you were moving.
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- import nvim-autopairs
      local autopairs = require("nvim-autopairs")

      -- configure autopairs
      autopairs.setup({
        check_ts = true,                      -- enable treesitter
        ts_config = {
          lua = { "string" },                 -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
          java = false,                       -- don't check treesitter on java
        },
      })

      -- import nvim-autopairs completion functionality
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      -- import nvim-cmp plugin (completions plugin)
      local cmp = require("cmp")

      -- make autopairs and completion work together
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
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
  {
    "ruifm/gitlinker.nvim",
    event = "VeryLazy",
    requires = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("gitlinker").setup({
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require "gitlinker.actions".copy_to_clipboard,
          -- print the url after performing the action
          print_url = true,
          -- mapping to call url generation
        },
        mappings = "<leader>gy",
        callbacks = {
          ["github.com"] = require("gitlinker.hosts").get_github_type_url,
          ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
        },
      })
    end,
  },
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
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
  },
  {
    "projekt0n/github-nvim-theme",
    event = "VeryLazy",
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require('lualine').setup {
        options = {
          -- theme = "solarized_dark",
          theme = "auto",
        }
      }
    end
  },
  {
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts) opts.statusline = nil end,
  },
  {
    "iCyMind/NeoSolarized",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    config = function()
      local status, n = pcall(require, "neosolarized")
      if (not status) then return end

      n.setup({
        comment_italics = true,
      })

      local cb = require('colorbuddy.init')
      local Color = cb.Color
      local colors = cb.colors
      local Group = cb.Group
      local groups = cb.groups
      local styles = cb.styles

      Color.new('white', '#ffffff')
      Color.new('black', '#000000')
      Group.new('Normal', colors.base1, colors.NONE, styles.NONE)
      Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
      Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
      Group.new('Visual', colors.none, colors.base03, styles.reverse)
      Group.new('NormalFloat', colors.base1, colors.NONE, styles.NONE)

      local cError = groups.Error.fg
      local cInfo = groups.Information.fg
      local cWarn = groups.Warning.fg
      local cHint = groups.Hint.fg

      Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
      Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
      Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
      Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
      Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

      Group.new("HoverBorder", colors.yellow, colors.none, styles.NONE)
    end
  },
  {
    "luisiacc/gruvbox-baby",
    event = "VeryLazy",
  },
  { "m-demare/hlargs.nvim", opts = {}, event = "User AstroFile" },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "storm",  -- The theme is used when the background is set to light
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",              -- style for sidebars, see below
          floats = "dark",                -- style for floating windows
        },
        sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false,             -- dims inactive windows
        lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

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
  -- {
  --   "Mofiqul/dracula.nvim",
  --   config = function()
  --     local dracula = require("dracula")
  --     dracula.setup({
  --       -- customize dracula color palette
  --       colors = {
  --         bg = "#282A36",
  --         fg = "#F8F8F2",
  --         selection = "#44475A",
  --         comment = "#6272A4",
  --         red = "#FF5555",
  --         orange = "#FFB86C",
  --         yellow = "#F1FA8C",
  --         green = "#50fa7b",
  --         purple = "#BD93F9",
  --         cyan = "#8BE9FD",
  --         pink = "#FF79C6",
  --         bright_red = "#FF6E6E",
  --         bright_green = "#69FF94",
  --         bright_yellow = "#FFFFA5",
  --         bright_blue = "#D6ACFF",
  --         bright_magenta = "#FF92DF",
  --         bright_cyan = "#A4FFFF",
  --         bright_white = "#FFFFFF",
  --         menu = "#21222C",
  --         visual = "#3E4452",
  --         gutter_fg = "#4B5263",
  --         nontext = "#3B4048",
  --       },
  --       -- show the '~' characters after the end of buffers
  --       show_end_of_buffer = true, -- default false
  --       -- use transparent background
  --       -- transparent_bg = true, -- default false
  --       -- set custom lualine background color
  --       lualine_bg_color = "#44475a", -- default nil
  --       -- set italic comment
  --       italic_comment = true, -- default false
  --       -- overrides the default highlights see `:h synIDattr`
  --       -- overrides = {
  --       --   -- Examples
  --       --   -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
  --       --   NvimTreeIndentMarker = {
  --       --     bg = "#21222C",
  --       --   }, -- link to NonText highlight
  --       --   NeoTreeNormal = {
  --       --     bg = "#21222C",
  --       --   },
  --       --   NeoTreeNormalNC = {
  --       --     bg = "#21222C",
  --       --   },
  --       --   -- Nothing = {} -- clear highlight of Nothing
  --       -- },
  --     })
  --   end,
  --   event = "VeryLazy"
  -- },
  {
    "maxmx03/dracula.nvim",
    -- opts = {},
    event = "VeryLazy"
  },
  {
    "ggandor/leap.nvim",
    keys = {
      { "s",  "<Plug>(leap-forward-to)",    mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  "<Plug>(leap-backward-to)",   mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "x",  "<Plug>(leap-forward-till)",  mode = { "x", "o" },      desc = "Leap forward till" },
      { "X",  "<Plug>(leap-backward-till)", mode = { "x", "o" },      desc = "Leap backward till" },
      { "gs", "<Plug>(leap-from-window)",   mode = { "n", "x", "o" }, desc = "Leap from window" },
    },
    opts = {},
    init = function() -- https://github.com/ggandor/leap.nvim/issues/70#issuecomment-1521177534
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=100")
          vim.opt.guicursor:append { "a:Cursor/lCursor" }
        end,
        pattern = "LeapEnter",
      })
      vim.api.nvim_create_autocmd("User", {
        callback = function()
          vim.cmd.hi("Cursor", "blend=0")
          vim.opt.guicursor:remove { "a:Cursor/lCursor" }
        end,
        pattern = "LeapLeave",
      })
    end,
    dependencies = {
      "tpope/vim-repeat",
    },
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { leap = true } },
  },
  {
    "catppuccin/nvim",
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
    "kylechui/nvim-surround",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "akinsho/git-conflict.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('git-conflict').setup({
        default_mappings = {
          ours = 'o',
          theirs = 't',
          none = '0',
          both = 'b',
          next = 'n',
          prev = 'p',
        }
      })
    end,
  },
  {
    -- "glepnir/lspsaga.nvim",
    "nvimdev/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lspsaga").setup({
        finder = {
          keys = {
            toggle_or_open = "<enter>",
          }
        },
        ui = {
          code_action = '',
          enable = flase,
          lines = { '┗', '┣', '┃', '', '┏' },
          expand = '',
          collapse = ''
        }
      })
    end,
    requires = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    event = "User AstroFile"
  }
}
