local g = vim.g

g.coq_settings = { auto_start = true }

local coq = require('coq')

local provide_capabilities = function(opts)
    return coq.lsp_ensure_capabilities(opts)
end

return { provide_capabilities = provide_capabiloties }
