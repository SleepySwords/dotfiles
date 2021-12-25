local dap = require "dap"

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.local/share/nvim/dap_servers/vscode-node-debug2/out/src/nodeDebug.js'},
}
dap.configurations.javascript = {
  {
    name = "Launch1",
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

