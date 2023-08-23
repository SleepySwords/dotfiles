local M = {}

function M.setup()
	-- local inlay_hint = require('lsp-inlayhints')
	-- inlay_hint.setup({
	-- 	inlay_hints = {
	-- 		highlight = "Comment"
	-- 	}
	-- })

	-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})

	-- vim.api.nvim_create_autocmd("LspAttach", {
	-- 	group = "LspAttach_inlayhints",
	-- 	callback = function(args)
	-- 		if not (args.data and args.data.client_id) then
	-- 			return
	-- 		end

	-- 		local bufnr = args.buf
	-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 		inlay_hint.on_attach(client, bufnr)
	-- 	end,
	-- })
end

return M
