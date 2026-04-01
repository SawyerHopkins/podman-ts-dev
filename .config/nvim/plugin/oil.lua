--[[
Enables directory and file management through a standard buffer interface.
Provides more information than mini files at the expensive of being a full screen float.
--]]

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/stevearc/oil.nvim' }, { confirm = false })

--[[ SETUP --]]

require('oil').setup({
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime'
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

vim.keymap.set('n', '<leader>fe', require('oil').open_float, { desc = 'File explorer (oil)' })
require('which-key').add({
  { '<leader>f', group = '[f]ile', icon = '' }
})


