--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/stevearc/oil.nvim' }, { confirm = false })

--[[ SETUP --]]

require('oil').setup({
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime"
  },
  view_options = {
    show_hidden = true
  },
  float = {
    padding = 4,
    border = 1
  },
  delete_to_trash = true
})

--[[ KEY BINDINGS --]]

vim.keymap.set("n", "<leader>o", require("oil").open_float, { desc = "Open Oil in float" })
