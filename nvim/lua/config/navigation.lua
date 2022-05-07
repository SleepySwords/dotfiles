-- Neovim tree
require'nvim-tree'.setup {
    view = {
	   side = 'right'
    },
    git = {
	enable = false
    },
    actions = {
	open_file = {
	    resize_window = true,
	    quit_on_open = true
	}
    }
}
