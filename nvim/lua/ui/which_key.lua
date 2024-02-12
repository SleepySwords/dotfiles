local M = {}

function M.setup()
	-- Cursor is really off, but oh welll
	vim.o.timeoutlen = 500
	require('which-key').setup {
		window = {
			position = 'bottom',
			border = 'solid',
			margin = { 1, 0, 1, 0.7 },
			padding = { 1, 1, 1, 1 }
		},
		-- show_help = false,
		layout = {
			height = { min = 10, max = 15 }, -- min and max width of the columns
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		-- triggers = ''
	}
	require('which-key').register({
		['<leader>w'] = { name = 'LSP Workspaces' },
		['<leader>x'] = { name = 'Trouble' },
		['<leader>a'] = { name = 'Test/Tree' },
		['<leader>d'] = { name = 'Debugger' },
		['<leader>h'] = { name = 'Help Tags/Highlights' },
		['<leader>o'] = { name = 'Org mode' },
		['<leader>c'] = { name = 'LSP Code Actions/Format + Colourscheme' },
	})
end

return M
