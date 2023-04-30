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

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

return {
  -- first key is the mode
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<S-l>"] = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end },
    ["<S-h>"] = { function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end },
    ["Y"] = { "yy" },
    ["<leader>x"] = { ":bp<bar>sp<bar>bn<bar>bd<CR>" },
    ["<leader>aa"] = mark.add_file,
    ["<leader>am"] = ui.toggle_quick_menu,
    ["<leader>1"] = function() ui.nav_file(1) end,
    ["<leader>2"] = function() ui.nav_file(2) end,
    ["<leader>3"] = function() ui.nav_file(3) end,
    ["<leader>4"] = function() ui.nav_file(4) end,
    ["K"] = "<cmd>Lspsaga hover_doc<CR>",
    ["gd"] = "<cmd>Lspsaga goto_definition<CR>",
    ["gD"] = "<cmd>Lspsaga peek_definition<CR>",
    ["gi"] = "<cmd>Lspsaga lsp_finder<CR>",
    ["<leader>r"] = "<cmd>Lspsaga rename<CR>",
    ["<leader>gp"] = "<cmd>Lspsaga diagnostic_jump_prev<CR>",
    ["<leader>gn"] = "<cmd>Lspsaga diagnostic_jump_next<CR>",
    ["<leader><S-k>"] = "<cmd>Lspsaga show_cursor_diagnostics<CR>",
    ["<C-H>"] = "<cmd>TmuxNavigateLeft<CR>",
    ["<C-L>"] = "<cmd>TmuxNavigateRight<CR>",
    ["<C-J>"] = "<cmd>TmuxNavigateDown<CR>",
    ["<C-K>"] = "<cmd>TmuxNavigateUp<CR>",
  },
  v = {
    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
    ["D"] = { "_D" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
