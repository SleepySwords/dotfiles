local M = {}

function M.setup()
	require('satellite').setup {
		handlers = {
			gitsigns = {
				enable = false,
			},
		},
	}
end

return M
