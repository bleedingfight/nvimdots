-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
return function()
	local dap = require("dap")
	local utils = require("modules.utils.dap")
	local is_windows = require("core.global").is_windows

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = vim.fn.exepath("codelldb"), -- Find codelldb on $PATH
			args = { "--port", "${port}" },
			detached = is_windows and false or true,
		},
	}

	dap.adapters.cudagdb = {
		type = "server",
		port = "${port}",
		program = "/opt/cuda/bin/cuda-gdbserver",
		executable = {
			command = vim.fn.exepath("codelldb"), -- Find codelldb on $PATH
			args = { "--port", "${port}" },
			detached = is_windows and false or true,
		},
	}

	-- Rust DAP is managed by rustaceanvim automatically

	dap.configurations.c = {
		{
			name = "Debug",
			type = "codelldb",
			request = "launch",
			program = utils.input_exec_path(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Debug (with args)",
			type = "codelldb",
			request = "launch",
			program = utils.input_exec_path(),
			args = utils.input_args(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Attach to a running process",
			type = "codelldb",
			request = "attach",
			program = utils.input_exec_path(),
			stopOnEntry = false,
			waitFor = true,
		},
	}
	-- 配置自定义C++ debug for codelldb
	dap.configurations.cpp = {
		{
			name = "Debug",
			type = "codelldb",
			request = "launch",
			program = utils.input_exec_path(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			runInTerminal = false,
			terminal = "integrated",
		},
		{
			name = "Debug (with args)",
			type = "codelldb",
			request = "launch",
			program = utils.input_exec_path(),
			args = utils.input_args(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			terminal = "integrated",
		},
		{
			name = "Attach to a running process",
			type = "codelldb",
			request = "attach",
			program = utils.input_exec_path(),
			stopOnEntry = false,
			waitFor = true,
		},
	}

	dap.configurations.cuda = {
		{
			name = "CUDA C++: Debug(cuda-gdb)",
			type = "cudagdb",
			request = "launch",
			program = utils.input_exec_path(),
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			runInTerminal = false,
			terminal = "integrated",
			debuggerPath="/opt/cuda/bin/cuda-gdb",
		},
		{
			name = "CUDA C++: Attatch (cuda-gdb with args)",
			type = "cudagdb",
			request = "launch",
			program = utils.input_exec_path(),
			args = utils.input_args(),
			cwd = "${workspaceFolder}",
			debuggerPath="/opt/cuda/bin/cuda-gdb",
			stopOnEntry = false,
			terminal = "integrated",
		},
	}
end
