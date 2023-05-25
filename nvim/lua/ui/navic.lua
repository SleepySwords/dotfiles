local M = {}

function M.setup()
	local navic = require('nvim-navic')
	navic.setup {
		separator = " -> ",
		highlight = true,
		icons = {
			File = ' ',
			Module = ' ',
			Namespace = ' ',
			Package = ' ',
			Class = ' ',
			Method = ' ',
			Property = ' ',
			Field = ' ',
			Constructor = ' ',
			Enum = ' ',
			Interface = ' ',
			Function = ' ',
			Variable = ' ',
			Constant = ' ',
			String = ' ',
			Number = ' ',
			Boolean = ' ',
			Array = ' ',
			Object = ' ',
			Key = ' ',
			Null = ' ',
			EnumMember = ' ',
			Struct = ' ',
			Event = ' ',
			Operator = ' ',
			TypeParameter = ' '
		}
	}

	vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#D8CFAF" })

	vim.api.nvim_create_augroup("LspAttach_navic", {})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = "LspAttach_navic",
		callback = function(args)
			if not (args.data and args.data.client_id) then
				return
			end

			local bufnr = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			navic.attach(client, bufnr)
		end,
	})
end

return M
