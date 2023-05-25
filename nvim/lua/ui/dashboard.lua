local g = vim.g

local db = require('dashboard')
require('splashscreen-sprites')

db.setup {
	theme = 'hyper',
	config = {
		header = g.portal_cake,
		shortcut = {
			{ desc = ' Update', group = '@property', action = 'PackerUpdate', key = 'u' },
			{
				desc = ' Files',
				group = 'Label',
				action = 'Telescope find_files',
				key = 'f',
			},
			-- {
			-- 	desc = ' dotfiles',
			-- 	group = 'Number',
			-- 	action = 'Telescope dotfiles',
			-- 	key = 'd',
			-- },
		},
	}
}

-- vim.cmd[[autocmd FileType dashboard set laststatus=0 | autocgmd WinLeave <buffer> set laststatus=3]]
