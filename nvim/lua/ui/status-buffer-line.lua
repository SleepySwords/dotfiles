-- Bufferline
if not vim.g.started_by_firenvim then
    require("bufferline").setup {
    }

    -- Should 100% not be here, but oh well.
    vim.o.laststatus = 0

    -- Current status line config
    require('ui.statusline.lualine.eviline')
end

-- Provides the status of an lsp in the statusline
require'lsp-status'.config {
    status_symbol = '',
    diagnostics = false
}
