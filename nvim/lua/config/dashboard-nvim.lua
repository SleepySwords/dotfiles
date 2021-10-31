local g = vim.g

require('splashscreen-sprites')

-- autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
g.dashboard_default_executive = 'telescope'
g.dashboard_custom_header = g.dashboard_custom_header6
g.dashboard_custom_footer = { 'Have fun writing bugs ;)' }
g.dashboard_custom_section = {
    a1_findfile = {
		description = { ' Find file                             SPC f f'},
		command = 'DashboardFindFile'
    },
    a2_newfile = {
		description = { ' New file                              SPC t c'},
		command = 'DashboardNewFile'
    },
    a3_changecolourscheme = {
		description = { ' Change colorscheme                    SPC t c'},
		command = 'DashboardChangeColorscheme'
    },
    a4_bookmarks = {
		description = { ' Jump to bookmarks                     SPC f b'},
		command = 'DashboardJumpMarks'
    },
    a5_history = {
		description = { ' Recently opened files                 SPC f h'},
		command = 'DashboardFindHistory'
    },
    a6_lastsession = {
		description = { ' Open last session                     SPC s l'},
		command = 'SessionLoad'
    },
    a7_findword = {
		description = { ' Find word                             SPC f a'},
		command = 'DashboardFindWord'
    },
    a8_quite = {
		description = { ' Quit                                  SPC b b'},
		command = 'q'
    },
}
