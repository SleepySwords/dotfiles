-- Telescope + DAP
require('telescope').load_extension('dap')
require('dap-python').setup('~/miniconda3/bin/python')

-- Neovim tree
require'nvim-tree'.setup {
    auto_close = false,
    auto_resize = true,
    view = {
	   side = 'right'
    }
}

-- Lsp Saga, LSP with nice UI
local saga = require 'lspsaga'
saga.init_lsp_saga()

