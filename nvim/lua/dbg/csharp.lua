local dap = require "dap"

dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.stdpath('data') .. '/mason/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    cwd = function()
        return vim.fn.input('Path to cwd: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
    program = function()
        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
