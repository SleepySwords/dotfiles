-- require('completion.lsp_ui_handlers')

require('lsp_extensions').inlay_hints()

local lsp_status = require('lsp-status')
-- use properly: https://github.com/nvim-lua/lsp-status.nvim
lsp_status.register_progress()

require('completion.lsp_sources')
require('completion.lsp_utils')
require('completion.lsp_error')
require('completion.lsp_utils')
