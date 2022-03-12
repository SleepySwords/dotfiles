local dap = require "dap"

dap.adapters.netcoredbg = {
  type = 'executable',
  command = '/Users/ibrahimhizamul/Stuff/Computer_Science/C#/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
