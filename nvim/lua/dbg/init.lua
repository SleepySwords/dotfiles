require("dapui").setup()

require('telescope').load_extension('dap')
require('dbg.python')
require('dbg.rust')
require('dbg.csharp')

require'nvim-dap-virtual-text'.setup()
