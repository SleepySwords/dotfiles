-- Neovim tree
require'nvim-tree'.setup {
    auto_close = false,
    auto_resize = true,
    view = {
	   side = 'right'
    },
    git = {
	enable = false
    },
    actions = {
	open_file = {
	    quit_on_open = true
	}
    }
}
