--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' }, { confirm = false })
vim.pack.add({ 'https://github.com/folke/which-key.nvim' }, { confirm = false })

--[[ SETUP --]]

require('mini.ai').setup()
require('mini.align').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.files').setup()
require('mini.keymap').setup()
require('mini.move').setup()
require('mini.operators').setup()
require('mini.pairs').setup()
require('mini.snippets').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()
require('mini.basics').setup()
require('mini.bracketed').setup()
require('mini.cmdline').setup()
require('mini.diff').setup()
require('mini.git').setup()
require('mini.sessions').setup()
require('mini.animate').setup()
require('mini.cursorword').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
local map = require('mini.map')
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
    map.gen_integration.diff(),
    map.gen_integration.diagnostic(),
  }
})
require('mini.notify').setup()
local starter = require('mini.starter')
starter.setup({
    items = {
      {
      starter.sections.sessions(3),
      starter.sections.recent_files(5, true, true),
      },
      starter.sections.builtin_actions(),
      starter.sections.telescope(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
})
require('mini.statusline').setup()
require('mini.tabline').setup()
require('mini.trailspace').setup()

--[[ KEY BINDINGS --]]

-- Minimap keys
vim.keymap.set('n', '<Leader>mc', MiniMap.close, { desc = 'Close minimap' })
vim.keymap.set('n', '<Leader>mf', MiniMap.toggle_focus, { desc = 'Toggle minimap focus' })
vim.keymap.set('n', '<Leader>mo', MiniMap.open, { desc = 'Open minimap' })
vim.keymap.set('n', '<Leader>mr', MiniMap.refresh, { desc = 'Refresh minimap' })
vim.keymap.set('n', '<Leader>ms', MiniMap.toggle_side, { desc = 'Toggle minimap side' })
vim.keymap.set('n', '<Leader>mt', MiniMap.toggle, { desc = 'Toggle minimap' })
require('which-key').add({
  { '<Leader>m', group = 'Minimap', icon = '' }
})

-- Sessions keys
vim.keymap.set("n", "<Leader>nvw", function()
  require("mini.sessions").write()
end, { desc = "Write current session" })

vim.keymap.set("n", "<Leader>nvr", function()
  require("mini.sessions").read()
end, { desc = "Read default session" })

vim.keymap.set("n", "<Leader>nvd", function()
  require("mini.sessions").delete()
end, { desc = "Delete current session" })
require('which-key').add({
  { '<Leader>m', group = 'Minimap', icon = '' }
})