local M = {}

function M.setup()
    local lsp_status = require('lsp-status')
    lsp_status.config({
        status_symbol = '',
        diagnostics = false,
    })
    lsp_status.register_progress()

    vim.api.nvim_create_augroup('LspAttach_status', {})

    vim.api.nvim_create_autocmd('LspAttach', {
        group = 'LspAttach_status',
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local client = vim.lsp.get_client_by_id(args.data.client_id)
            lsp_status.on_attach(client)
        end,
    })
end

return M
