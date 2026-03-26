vim.opt.tabstop = 2         -- Number of spaces that a <Tab> character displays as
vim.opt.shiftwidth = 2      -- Number of spaces used for each step of (auto)indent
vim.opt.softtabstop = 2     -- Number of spaces a <Tab> counts for while editing (in insert mode)
vim.opt.expandtab = true    -- Convert tabs to spaces (insert spaces instead of literal tab characters)
vim.opt.foldlevelstart = 99 -- Initial fold level when opening a file (99 = effectively all folds open)
vim.o.mousemoveevent = true -- Enable mouse move events (triggers events on mouse movement, useful for plugins/UI) 