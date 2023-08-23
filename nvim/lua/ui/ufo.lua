local M = {}

function M.setup()
	require('ufo').setup({
		provider_selector = function(bufnr, filetype, buftype)
			if filetype == "markdown" then
				return { 'treesitter', 'indent' }
			else
				return { 'lsp', 'indent' }
			end
		end
	})
end

return M
