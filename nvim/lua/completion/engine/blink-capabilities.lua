local provide_capabilities = function(opts)
    local caps = require('blink.cmp').get_lsp_capabilities(opts)
    opts.capabilities = caps
    return caps
end

return { provide_capabilities = provide_capabilities }
