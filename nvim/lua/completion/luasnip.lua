local M = {}

function M.setup()
	require('luasnip').config.set_config({ history = true, updateevents = 'TextChanged,TextChangedI' })
	require('luasnip.loaders.from_vscode').lazy_load()
end

return M
