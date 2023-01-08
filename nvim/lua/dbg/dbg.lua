require('dap')
require('dbg.rust')
require('dbg.csharp')
require('dbg.python')
require('dbg.javascript')

require'nvim-dap-virtual-text'.setup()

-- Telescope + DAP
local telescope = require('telescope')
telescope.load_extension('dap')
telescope.load_extension("undo")

-- Is only for Sonokai
vim.fn.sign_define('DapBreakpoint', {text='', texthl='Red', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})

require('dap.ext.vscode').load_launchjs()
