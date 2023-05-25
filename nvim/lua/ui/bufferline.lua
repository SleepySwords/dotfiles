local M = {}

function M.setup()
	require("bufferline").setup {
		options = {
			numbers = "both"
		}
	}
end

return M
