-- Bufferline
require("bufferline").setup {
}

-- Provides the status of an lsp in the statusline
require'lsp-status'.config {
    status_symbol = '',
    diagnostics = false
}

-- Current status line config
require('ui.statusline.lualine.eviline')
