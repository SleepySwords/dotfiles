require('ui.dashboard-nvim')
require('ui.status-buffer-line')

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		dynamic_preview_title = true,
		results_title = false,
		selection_caret = " > ",
		entry_prefix = "   ",
		mappings = {
			i = {
				["<tab>"] = actions.move_selection_next,
				["<S-tab>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
			},
		},
	},
})
