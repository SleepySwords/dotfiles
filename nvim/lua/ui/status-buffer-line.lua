-- Bufferline
require("bufferline"):setup{
    show_close_icon = false,
    diagnostics = "nvim_lsp"
}

-- Provides the status of an lsp in the statusline
require'lsp-status'.config {
    status_symbol = ''
}

-- Current status line config
require('ui.statusline.eviline')

