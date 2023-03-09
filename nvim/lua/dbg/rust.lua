local dap = require "dap"

-- Still buggy when stopiing

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'


dap.adapters.lldb = {
	type = 'executable',
	command = '/opt/homebrew/opt/llvm/bin/lldb-vscode',
	name = "lldb",
}

dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--liblldb", liblldb_path, "--port", "${port}" },
	},
	name = "codelldb",
}

dap.configurations.cpp = {
	{
		name = "Launch - CodeLLDB",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
				'file')
		end,
		-- cwd = '${workspaceFolder}',
		cwd = function()
			return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/',
				'file')
		end,
		stopOnEntry = false,
		args = {},

		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
		sourceLanguages = { "rust" }
	},
	{
		name = "Launch - lldb",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
				'file')
		end,
		cwd = function()
			return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/',
				'file')
		end,
		stopOnEntry = true,
		args = {},
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach - CodeLLDB",
		type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
		-- sourceLanguages = { "rust" },
	},
	{
		name = "Cargo test",
		type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = "launch",
		cargo = {
			args = { "test" }
		},
		cwd = function()
			return vim.fn.input('Path to workspace: ', vim.fn.getcwd() .. '/',
				'file')
		end,
		-- sourceLanguages = { "rust" },
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach - LLDB",
		type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
		-- sourceLanguages = { "rust" },
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
