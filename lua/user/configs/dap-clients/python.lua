return function()
	local dap = require("dap")
	local utils = require("modules.utils.dap")
	local is_windows = require("core.global").is_windows
	local debugpy_root = vim.fn.expand("$MASON/packages/debugpy")

	dap.adapters.python = function(callback, config)
		if config.request == "attach" then
			local port = (config.connect or config).port
			local host = (config.connect or config).host or "127.0.0.1"
			callback({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = { source_filetype = "python" },
			})
		else
			callback({
				type = "executable",
				command = is_windows and debugpy_root .. "/venv/Scripts/pythonw.exe"
					or debugpy_root .. "/venv/bin/python",
				args = { "-m", "debugpy.adapter" },
				options = { source_filetype = "python" },
			})
		end
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Debug",
			console = "integratedTerminal",
			program = utils.input_file_path(),
			pythonPath = function()
				local venv = vim.env.CONDA_PREFIX
				if venv then
					return is_windows and venv .. "/Scripts/pythonw.exe" or venv .. "/bin/python"
				else
					return is_windows and "pythonw.exe" or "python3"
				end
			end,
		},
		{
			type = "python",
			request = "launch",
			name = "Debug (using venv)",
			console = "integratedTerminal",
			program = utils.input_file_path(),
			pythonPath = function()
				local cwd, venv = vim.fn.getcwd(), os.getenv("VIRTUAL_ENV")
				local python = venv and (is_windows and venv .. "/Scripts/pythonw.exe" or venv .. "/bin/python") or ""
				if vim.fn.executable(python) == 1 then
					return python
				end

				venv = vim.fn.isdirectory(cwd .. "/venv") == 1 and cwd .. "/venv" or cwd .. "/.venv"
				python = is_windows and venv .. "/Scripts/pythonw.exe" or venv .. "/bin/python"
				if vim.fn.executable(python) == 1 then
					return python
				else
					return is_windows and "pythonw.exe" or "python3"
				end
			end,
		},
		{
			type = "python",
			request = "attach",
			name = "Attach Remote",
			console = "integratedTerminal",
			connect = function()
				local host = vim.fn.input("Host [127.0.0.1]: ")
				if host == "" then
					host = "127.0.0.1"
				end
				local port = vim.fn.input("Port [5679]: ")
				if port == "" then
					port = "5679"
				end
				return { host = host, port = tonumber(port) }
			end,
			justMyCode = false,
		},
	}
end
