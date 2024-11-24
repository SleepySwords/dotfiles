local cmp_nvim_lsp = require('cmp_nvim_lsp')

local provide_capabilities = function(opts)
    opts.capabilities =
        vim.tbl_extend('keep', cmp_nvim_lsp.default_capabilities({
        resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
                "sortText",
                "filterText",
                "insertText",
                "insertTextFormat",
                "insertTextMode"
            }
        }
    }), opts.capabilities)
    return opts
end

return { provide_capabilities = provide_capabilities }
