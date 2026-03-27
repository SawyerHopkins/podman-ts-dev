--[[
Provides language parsing for syntax highlighting, indentation and folding.
--]]

--[[ PRE-INSTALL --]]

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

--[[ INSTALL --]]

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-context' }, { confirm = false })
vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' }, { confirm = false })

--[[ SETUP --]]

local nts = require('nvim-treesitter')
nts.install({
  -- 'bash',
  -- 'css',
  -- 'dockerfile',
  -- 'git_config',
  -- 'git_rebase',
  -- 'gitattributes',
  -- 'gitcommit',
  -- 'gitignore',
  -- 'html',
  -- 'javascript',
  -- 'json',
  -- 'robots_txt',
  -- 'scss',
  -- 'sql',
  -- 'tsx',
  'typescript',
  -- 'vim',
  'vue',
  -- 'xml',
  -- 'yaml'
})

require('treesitter-context').setup({
  enabled = true
})
require('nvim-treesitter-textobjects').setup({
    select = {
    lookahead = true,
    include_surrounding_whitespace = false,
  },
  move = {
    lookahead = true,
    -- whether to set jumps in the jumplist
    set_jumps = true,
  },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.wo[0][0].foldmethod = 'expr'
      vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
      vim.treesitter.start()
    end
  end
})

--[[ KEY BINDINGS --]]

-- Content selection
vim.keymap.set({ 'x', 'o' }, 'am', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@function.outer', 'textobjects')
end, { desc = 'Select function' })
vim.keymap.set({ 'x', 'o' }, 'im', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@function.inner', 'textobjects')
end, { desc = 'Select function content' })
vim.keymap.set({ 'x', 'o' }, 'ac', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@class.outer', 'textobjects')
end, { desc = 'Select class' })
vim.keymap.set({ 'x', 'o' }, 'ic', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@class.inner', 'textobjects')
end, { desc = 'Select class content' })
vim.keymap.set({ 'x', 'o' }, 'as', function()
  require 'nvim-treesitter-textobjects.select'.select_textobject('@local.scope', 'locals')
end, { desc= 'Select block content' })

-- Parameter swapping
vim.keymap.set('n', '<leader>a', function()
  require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
end, { desc = 'Swap inner parameters' })
vim.keymap.set('n', '<leader>A', function()
  require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.outer'
end, { desc = 'Swap outer parameters' })

-- Goto next start
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
end, { desc = 'Goto next class start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Goto next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@loop.outer', 'textobjects')
end, { desc = 'Goto next loop start'})
vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects')
end, { desc = 'Goto next condition start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
end, { desc = 'Goto next block start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
end, { desc = 'Goto next fold start' })

vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
end, { desc = 'Goto next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
end, { desc = 'Goto next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']O', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@loop.outer', 'textobjects')
end, { desc = 'Goto next loop end'})
vim.keymap.set({ 'n', 'x', 'o' }, ']D', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@conditional.outer', 'textobjects')
end, { desc = 'Goto next condition end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']S', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@local.scope', 'locals')
end, { desc = 'Goto next block end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']Z', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@fold', 'folds')
end, { desc = 'Goto next fold end' })

vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'Goto previous class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Goto previous function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[o', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@loop.outer', 'textobjects')
end, { desc = 'Goto previous loop start'})
vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@conditional.outer', 'textobjects')
end, { desc = 'Goto previous condition start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[s', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@local.scope', 'locals')
end, { desc = 'Goto previous block start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[z', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@fold', 'folds')
end, { desc = 'Goto previous fold start' })

vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
end, { desc = 'Goto previous class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
end, { desc = 'Goto previous function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[O', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@loop.outer', 'textobjects')
end, { desc = 'Goto previous loop end'})
vim.keymap.set({ 'n', 'x', 'o' }, '[D', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@conditional.outer', 'textobjects')
end, { desc = 'Goto previous condition end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[S', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@local.scope', 'locals')
end, { desc = 'Goto previous block end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[Z', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@fold', 'folds')
end, { desc = 'Goto previous fold end' })
