vim.g.dap_virtual_text = true
require("dapui").setup()

require('telescope').load_extension('dap')
require('dbg.python')
require('dbg.rust')
require('dbg.csharp')
