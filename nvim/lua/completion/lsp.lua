require('completion.lsp_sources').setup()
local diagnostic_signs = require('completion.diagnostic_signs')

require('completion.signature.handler').setup()

-- Shows error diagnostics on cursor hold
-- vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})', true)

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

-- Workaround until https://github.com/neovim/neovim/issues/30985 is resolved
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
    local default_diagnostic_handler = vim.lsp.handlers[method]
    vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
            return
        end
        return default_diagnostic_handler(err, result, context, config)
    end
end
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('InlayHintsAttach', {}),
--     callback = function(args)
--       local buf = args.buf
--       vim.lsp.inlay_hint(buf, true)
--     end,
-- })
