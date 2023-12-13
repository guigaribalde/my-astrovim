return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  colorscheme = "fluoromachine",
  -- colorscheme = "dracula",
  -- colorscheme = "tokyonight-storm",
  -- colorscheme = "github_dark_colorblind",
  -- colorscheme = "NeoSolarized",

  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
      disabled = {      -- disable formatting capabilities for the listed language servers
        "tsserver",
        "typescript-language-server",
      },
      timeout_ms = 1000, -- default format timeout
    },
  },
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  polish = function()
    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    require("lspconfig").clangd.setup {
      on_attach = on_attach,
      capabilities = cmp_nvim_lsp.default_capabilities(),
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    }

    require("lspconfig").tsserver.setup({
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
    })
    vim.notify = function(_, _, _)

    end
    local notify = require "notify"
    local currNot = vim.notify
    if currNot == notify then
      vim.notify = function(_, _, _)

      end
    end

    local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
    if not web_devicons_ok then
      return
    end

    local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
    if not material_icon_ok then
      return
    end

    web_devicons.setup({
      override = material_icon.get_icons(),
    })

    vim.o.termguicolors = true

    local highlights = require("neo-tree.ui.highlights")

    -- Telescope ignore large fileslocal previewers = require('telescope.previewers')
    local previewers = require('telescope.previewers')
    local new_maker = function(filepath, bufnr, opts)
      opts = opts or {}

      filepath = vim.fn.expand(filepath)
      vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then return end
        if stat.size > 100000 then
          return
        else
          previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
      end)
    end


    require('telescope').setup {
      defaults = {
        buffer_previewer_maker = new_maker,
      }
    }

    -- Git signs
    require('gitsigns').setup {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },

      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 0,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author> (<author_time:%R>) -  <summary>',
    }
  end,
}
