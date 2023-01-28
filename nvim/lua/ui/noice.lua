require("noice").setup({
	messages = {
		-- NOTE: If you enable messages, then the cmdline is enabled automatically.
		-- This is a current Neovim limitation.
		enabled = false, -- enables the Noice messages UI
		view = "mini", -- default view for messages
		view_error = "mini", -- view for errors
		view_warn = "mini", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
	},
	-- presets = {
	-- 	bottom_search = true, -- use a classic bottom cmdline for search
	-- },
	lsp = {
		progress = {
			enabled = false,
		}
	},
	views = {
		cmdline_popup = {
			border = {
				-- style = "none",
				-- padding = { 1, 2 },
				style = 'single',
			},
			filter_options = {},
			-- win_options = {
			-- 	winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
			-- },
		},
	},
})
