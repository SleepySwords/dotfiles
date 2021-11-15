local g = vim.g

g.coq_settings = { auto_start = true }

local coq = require('coq')
local completion = {}

completion.provide_capabilities = function(opts)
	return coq.lsp_ensure_capabilities(opts)
end

return completion
