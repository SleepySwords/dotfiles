-- Telescope + DAP
-- local telescope = require('telescope')
-- telescope.load_extension('dap')

-- Neovim tree
require'nvim-tree'.setup {
    auto_close = false,
    auto_resize = true,
    view = {
	   side = 'right'
    },
    actions = {
	open_file = {
	    quit_on_open = true
	}
    }
}
