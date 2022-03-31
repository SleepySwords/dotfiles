-- Telescope + DAP
-- local telescope = require('telescope')
-- telescope.load_extension('dap')

-- Neovim tree
vim.g.nvim_tree_quit_on_open = 1
require'nvim-tree'.setup {
    auto_close = false,
    auto_resize = true,
    view = {
	   side = 'right'
    }
}
