local M = {}

function M.setup()
    local dap = require('dap')

    dap.defaults.fallback.external_terminal = {
        command = '/Applications/kitty.app/Contents/MacOS/kitty',
        args = { '-e' },
    }

    require('dbg.rust')
    require('dbg.csharp')
    require('dbg.python')
    require('dbg.javascript')
    require('dbg.haskell')
    require('dbg.lua')

    require('nvim-dap-virtual-text').setup({})

    -- Telescope + DAP
    local telescope = require('telescope')
    telescope.load_extension('dap')

    -- Is only for Sonokai
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticSignError', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

    -- require('dap.ext.vscode').load_launchjs()
end

return M
