local M = {}

function M.setup()
	local null_ls = require 'null-ls'
	null_ls.setup()
	require("mason-null-ls").setup()
end

return M
