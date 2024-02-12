local M = {}

function M.setup()
	-- A little bit too laggy rn
	require('satellite').setup {
		handlers = {
			gitsigns = {
				enable = false,
			},
		},
	}
end

return M
