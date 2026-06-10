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

	local function resolve_python_path()
		-- 1. CONDA_PREFIX
		local venv = vim.env.CONDA_PREFIX
		if venv then
			local python = is_windows and venv .. "/Scripts/pythonw.exe" or venv .. "/bin/python"
			if vim.fn.executable(python) == 1 then
				return python
			end
		end

		-- 2. VIRTUAL_ENV (standard venv / uv venv)
		venv = os.getenv("VIRTUAL_ENV")
		if venv then
			local python = is_windows and venv .. "/Scripts/pythonw.exe" or venv .. "/bin/python"
			if vim.fn.executable(python) == 1 then
				return python
			end
		end

		-- 3. Search local venv directories under cwd
		local cwd = vim.fn.getcwd()
		for _, dir in ipairs({ "venv", ".venv" }) do
			local python = is_windows and cwd .. "/" .. dir .. "/Scripts/pythonw.exe"
				or cwd .. "/" .. dir .. "/bin/python"
			if vim.fn.executable(python) == 1 then
				return python
			end
		end

		return is_windows and "pythonw.exe" or "python3"
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Debug",
			console = "integratedTerminal",
			program = utils.input_file_path(),
			pythonPath = resolve_python_path,
		},
		{
			type = "python",
			request = "launch",
			name = "Debug (using venv)",
			console = "integratedTerminal",
			program = utils.input_file_path(),
			pythonPath = resolve_python_path,
		},
		{
			type = "python",
			request = "attach",
			name = "Attach Remote",
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
			pathMappings = function()
				local remote = vim.fn.input("Remote root [/home/liushuai/sglang-dev/lib/python3.12/site-packages/sglang]: ")
				if remote == "" then
					remote = "/home/liushuai/sglang-dev/lib/python3.12/site-packages/sglang"
				end
				local local_root = vim.fn.input("Local root [" .. vim.fn.getcwd() .. "]: ")
				if local_root == "" then
					local_root = vim.fn.getcwd()
				end
				return {
					{ remoteRoot = remote, localRoot = local_root },
				}
			end,
			justMyCode = false,
		},
	}
end
