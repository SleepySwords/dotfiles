require('completion.lsp_sources')

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

-- Shows error diagnostics on cursor hold + specifies a dot for the inlay hint
vim.cmd("autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})", true)
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
	prefix = '●', -- Could be '■', '▎', 'x'
    },
    signs = true,
    underline = true,
    update_in_insert = false -- true,
})

-- Define the signs for the left number bar
local signs = { Error = " ", Warn = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
