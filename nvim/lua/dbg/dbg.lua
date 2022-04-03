require('dap')
require('dbg.rust')
require('dbg.csharp')
require('dbg.python')
require('dbg.javascript')

require'nvim-dap-virtual-text'.setup()

-- Is only for Sonokai
vim.fn.sign_define('DapBreakpoint', {text='', texthl='Red', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})
