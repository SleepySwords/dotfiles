local g = vim.g

local db = require('dashboard')
require('splashscreen-sprites')

-- autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
g.dashboard_default_executive = 'telescope'
db.custom_header = g.dashboard_custom_header6
db.preview_file_height = 12
db.preview_file_width = 80
db.center_pad = 2
db.custom_center = {
	{
		desc = 'Find file                      ',
		shortcut = 'SPC f f',
		icon = ' ',
		action = 'Telescope find_files find_command=rg,--hidden,--files'
	},
	{
		desc = 'New file                       ',
		shortcut = 'SPC t c',
		icon = ' ',
		action = 'DashboardNewFile'
	},
	{
		desc = 'Change colorscheme             ',
		shortcut = 'SPC t c',
		icon = ' ',
		action = 'Colors'
	},
	-- {
	-- 	desc = 'Jump to bookmarks              ',
	-- 	shortcut = 'SPC f b',
	-- 	icon = ' ',
	-- 	action = 'DashboardJumpMarks'
	-- },
	-- {
	-- 	desc = 'Recently opened files          ',
	-- 	shortcut = 'SPC f h',
	-- 	icon = ' ',
	-- 	action = 'DashboardFindHistory'
	-- },
	{
		desc = 'Open last session              ',
		shortcut = 'SPC s l',
		icon = ' ',
		action = 'SessionLoad'
	},
	-- {
	-- 	desc = 'Find word                      ',
	-- 	shortcut = 'SPC f a',
	-- 	icon = ' ',
	-- 	action = 'DashboardFindWord'
	-- },
	{
		desc = 'Quit                           ',
		shortcut = 'SPC b b',
		icon = ' ',
		action = 'q'
	},
}
