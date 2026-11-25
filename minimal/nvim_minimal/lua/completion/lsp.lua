local M = {}

require('completion.lsp_servers').setup()

local diagnostic_signs = require('completion.diagnostic_signs')
local diagnostic_highlights = {
    [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
}

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
    },
    signs = {
        text = diagnostic_signs,
        numhl = diagnostic_highlights,
    },
    underline = true,
    update_in_insert = false,
})

return M
