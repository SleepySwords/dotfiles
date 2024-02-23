require('completion.lsp_sources')

local signature_config = {
    log_path = vim.fn.expand('$HOME') .. '/tmp/sig.log',
    -- debug = true,
    hint_enable = false,
    -- noice = true,
    doc_lines = 0,
    padding = ' ',
    max_width = 160,

    handler_opts = {
        border = 'solid',
    },
    toggle_key = '<M-x>',
}

require('lsp_signature').setup(signature_config)

-- Shows error diagnostics on cursor hold + specifies a dot for the inlay hint
vim.cmd('autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})', true)
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = '●',
        },
        signs = true,
        underline = true,
        update_in_insert = false,
    })

-- Define the signs for the left number bar
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('InlayHintsAttach', {}),
--     callback = function(args)
--       local buf = args.buf
--       vim.lsp.inlay_hint(buf, true)
--     end,
-- })
