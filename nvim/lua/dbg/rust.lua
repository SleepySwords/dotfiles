local dap = require "dap"

-- Still buggy when stopiing

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.9.0/'
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

dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = os.getenv("HOME") .. '/Stuff/computer_science/dbg/cpptools-osx-arm64/extension/debugAdapters/lldb-mi/bin/lldb-mi',
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
		-- If you get an "Operation not permitted" error using this, try disabling YAMA:
		--  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		name = "Attach (manual process) - CodeLLDB",
		type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
		request = 'attach',
		pid = function()
			return vim.fn.input('Process ID: ')
		end,
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
	{
		name = "Neovim",
		type = "codelldb",
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
		args = { "--clean" },
		externalConsole = true,
	}
	-- {
	-- 	__call = function(config)
	-- 		vim.fn.system("CMAKE_BUILD_TYPE=RelWithDebInfo make")
	-- 		local key = "a-unique-arbitrary-key"

	-- 		-- ⬇️ `dap.listeners.<before | after>.<event_or_command>.<plugin_key>`
	-- 		-- We listen to the `initialize` response. It indicates a new session got initialized
	-- 		dap.listeners.after.initialize[key] = function(session)
	-- 			-- ⬇️ immediately clear the listener, we don't want to run this logic for additional sessions
	-- 			dap.listeners.after.initialize[key] = nil

	-- 			-- The first argument to a event or response is always the session
	-- 			-- A session contains a `on_close` table that allows us to register functions
	-- 			-- that get called when the session closes.
	-- 			-- We use this to ensure the listeners get cleaned up
	-- 			session.on_close[key] = function()
	-- 				for _, handler in pairs(dap.listeners.after) do
	-- 					handler[key] = nil
	-- 				end
	-- 			end
	-- 		end

	-- 		-- We listen to `event_process` to get the pid:
	-- 		dap.listeners.after.event_process[key] = function(_, body)
	-- 			-- ⬇️ immediately clear the listener, we don't want to run this logic for additional sessions
	-- 			dap.listeners.after.event_process[key] = nil

	-- 			local ppid = body.systemProcessId
	-- 			-- The pid is the parent pid, we need to attach to the child. This uses the `ps` tool to get it
	-- 			-- It takes a bit for the child to arrive. This uses the `vim.wait` function to wait up to a second
	-- 			-- to get the child pid.
	-- 			vim.wait(1000, function()
	-- 				return tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid))) ~= nil
	-- 			end)
	-- 			local pid = tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid)))

	-- 			-- If we found it, spawn another debug session that attaches to the pid.
	-- 			if pid then
	-- 				dap.run({
	-- 					name = "Neovim embedded",
	-- 					type = "cppdbg",
	-- 					request = "attach",
	-- 					processId = pid,
	-- 					-- ⬇️ Change paths as needed
	-- 					program = os.getenv("HOME") .. "/dev/neovim/neovim/build/bin/nvim",
	-- 					cwd = os.getenv("HOME") .. "/dev/neovim/neovim/",
	-- 					externalConsole = false,
	-- 				})
	-- 			end
	-- 		end
	-- 		return config
	-- 	end
	-- }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
