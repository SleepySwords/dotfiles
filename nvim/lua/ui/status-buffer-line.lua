-- Bufferline
vim.g.started_by_firenvim = false
if not vim.g.started_by_firenvim then
	require("bufferline").setup {
		options = {
			numbers = "both"
		}
	}
	-- require("ui.tabby")

	-- Current status line config
	-- require('ui.statusline.lualine.eviline')
	require('ui.statusline.feline.eviline')
else
	-- Should 100% not be here, but oh well.
	vim.o.laststatus = 0
end

-- Provides the status of an lsp in the statusline
require 'lsp-status'.config {
	status_symbol = '',
	diagnostics = false
}
