-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
return function()
	local dap = require("dap")
	local utils = require("modules.utils.dap")

	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/gdb"
	}
	dap.adapters.gdb = {
		type = "executable",
		command = "/home/liushuai/.cargo/bin/rust-gdb"
	}
	dap.configurations.c = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = utils.input_exec_path(),
			cwd = "${workspaceFolder}",
			args = utils.input_args(),
			env = utils.get_env(),
                        setupCommands = {  
                          { 
                             text = '-enable-pretty-printing',
                             description =  'enable pretty printing',
                             ignoreFailures = false 
                          },
                        },
			logging = {
				engineLogging = true,  -- 日志输出调试
			},

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
			runInTerminal = false,
		},
	}
	dap.configurations.cpp = 
	{
		{
			name = "Launch file",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. 'file')
			end,
			cwd = '${workspaceFolder}',
			MIMode = 'gdb',
			miDebuggerPath = '/usr/bin/gdb',
                        setupCommands = {  
                          { 
                             text = '-enable-pretty-printing',
                             description =  'enable pretty printing',
                             ignoreFailures = false 
                          },
                        },
			logging = {
				engineLogging = true,  -- 日志输出调试
			},
			stopAtEntry = true,
		},
		{
			name = 'Attach to gdbserver :1236',
			type = 'cppdbg',
			request = 'launch',
			MIMode = 'gdb',
			miDebuggerServerAddress = 'localhost:1234',
			miDebuggerPath = '/usr/bin/gdb',
			cwd = '${workspaceFolder}',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
		},
	}
	dap.configurations.rust = 
	{
		{
			name = "Launch Rust file",
			type = "gdb",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. 'file')
			end,
			cwd = '${workspaceFolder}',
			-- miDebuggerPath = '/usr/bin/gdb',
                        setupCommands = {  
                          { 
                             text = '-enable-pretty-printing',
                             description =  'enable pretty printing',
                             ignoreFailures = false 
                          },
                        },
			logging = {
				engineLogging = true,  -- 日志输出调试
			},
			stopAtEntry = true,
		},
		{
			name = 'Attach to gdbserver :1235',
			type = 'cppdbg',
			request = 'launch',
			MIMode = 'gdb',
			miDebuggerServerAddress = 'localhost:1235',
			miDebuggerPath = '/usr/bin/gdb',
			cwd = '${workspaceFolder}',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
		},
	}

end
