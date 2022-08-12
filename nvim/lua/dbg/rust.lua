local dap = require "dap"

-- Still buggy when stopiing

dap.adapters.lldb = {
	type = 'executable',
	attach = { pidProperty = "pid", pidSelect = "ask" },
	command = '/usr/local/opt/llvm/bin/lldb-vscode',
	name = "lldb",
	env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" }
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
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
		runInTerminal = false
	},
	{
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach to process",
		type = 'lldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = 'attach',
		pid = require('dap.utils').pick_process,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
