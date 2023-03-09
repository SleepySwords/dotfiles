-- require('completion.lsp_ui_handlers')

-- require('lsp_extensions').inlay_hints()

local lsp_status = require('lsp-status')
-- use properly: https://github.com/nvim-lua/lsp-status.nvim
lsp_status.register_progress()

require('completion.lsp_sources')
require('completion.lsp_utils')
require('completion.lsp_error')
require('completion.lsp_utils')

local signature_config = {
	log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
	-- debug = true,
	hint_enable = false,
	-- noice = true,
	doc_lines = 0,
	padding = ' ',
	max_width = 160,

	handler_opts = {
		border = "solid",
	}
}

require("lsp_signature").setup(signature_config)
