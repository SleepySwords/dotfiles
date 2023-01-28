-- Neovim tree
require 'nvim-tree'.setup {
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
	},
	renderer = {
		full_name = true,
		group_empty = true,
		special_files = {},
		symlink_destination = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			git_placement = "signcolumn",
			show = {
				file = true,
				folder = false,
				folder_arrow = false,
				git = true,
			},
		},
	},
}
