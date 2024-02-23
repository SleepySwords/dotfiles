local dap = require('dap')

-- Still buggy when stopiing

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

dap.adapters.lldb = {
    type = 'executable',
    command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
    name = 'lldb',
}

dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
        command = codelldb_path,
        -- args = { "--port", "${port}" },
        args = { '--liblldb', liblldb_path, '--port', '${port}' },
    },
    name = 'codelldb',
}

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = os.getenv('HOME')
        .. '/Stuff/dev/dbg/cpptools-osx-arm64/extension/debugAdapters/bin/OpenDebugAD7',
}

dap.defaults.fallback.external_terminal = {
    command = '/Applications/kitty.app/Contents/MacOS/kitty',
    args = { '-e' },
}

dap.configurations.cpp = {
    {
        name = 'Launch - CodeLLDB',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        -- cwd = '${workspaceFolder}',
        cwd = function()
            return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopOnEntry = false,
        args = {},

        sourceLanguages = { 'rust' },
    },
    {
        name = 'Launch - CodeLLDB Options',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        -- cwd = '${workspaceFolder}',
        cwd = function()
            return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/', 'file')
        end,
        stopOnEntry = false,
        args = function()
            return { vim.fn.input('Options: ', '', 'file') }
        end,

        sourceLanguages = { 'rust' },
    },
    -- {
    -- 	name = "Launch - Cppdbg",
    -- 	type = "cppdbg",
    -- 	-- type = "lldb",
    -- 	request = "launch",
    -- 	program = function()
    -- 		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
    -- 			'file')
    -- 	end,
    -- 	cwd = function()
    -- 		return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/',
    -- 			'file')
    -- 	end,
    -- 	stopOnEntry = true,
    -- 	args = {},
    -- },
    {
        -- If you get an "Operation not permitted" error using this, try disabling YAMA:
        --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        name = 'Attach - CodeLLDB',
        type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
        request = 'attach',
        pid = require('dap.utils').pick_process,
        args = {},
        -- sourceLanguages = { "rust" },
    },
    {
        name = 'Attach (manual process) - CodeLLDB',
        type = 'codelldb',
        request = 'attach',
        pid = function()
            return vim.fn.input('Process ID: ')
        end,
        args = {},
        sourceLanguages = { 'rust' },
    },
    -- {
    -- 	name = "Attach (manual process) - CppDbg",
    -- 	type = 'cppdbg',
    -- 	request = 'attach',
    -- 	program = function()
    -- 		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
    -- 			'file')
    -- 	end,
    -- 	processId = function()
    -- 		return vim.fn.input('Process ID: ')
    -- 	end,
    -- 	MIMode = "lldb",
    -- 	args = {},
    -- },
    {
        name = 'Cargo test',
        type = 'codelldb',
        request = 'launch',
        cargo = {
            args = { 'test' },
        },
        cwd = function()
            return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/', 'file')
        end,
        sourceLanguages = { 'rust' },
    },
    -- {
    -- 	-- If you get an "Operation not permitted" error using this, try disabling YAMA:
    -- 	--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    -- 	name = "Attach - LLDB",
    -- 	type = '',
    -- 	request = 'attach',
    -- 	pid = require('dap.utils').pick_process,
    -- 	args = {},
    -- 	-- sourceLanguages = { "rust" },
    -- },
    -- {
    -- 	name = "Neovim",
    -- 	type = "codelldb",
    -- 	request = "launch",
    -- 	program = os.getenv("HOME") .. '/Stuff/dev/c/neovim/build/bin/nvim',
    -- 	cwd = os.getenv("HOME") .. '/Stuff/dev/c/neovim/',
    -- 	initCommands = { "settings set target.process.follow-fork-mode child" },
    -- 	args = { "--clean" },
    -- 	terminal = 'external',
    -- }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
