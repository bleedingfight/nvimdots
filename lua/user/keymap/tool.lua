local bind = require("keymap.bind")
local map_callback = bind.map_callback

local plug_map = {
	["n|<leader>fp"] = map_callback(function()
		if vim.fn.executable("elio") ~= 1 then
			vim.notify("Command [elio] not found!", vim.log.levels.ERROR, { title = "elio" })
			return
		end

		local elio_selected = os.tmpname()
		local elio_cwd = os.tmpname()

		-- Create opener script: writes the selected file path and exits
		local opener = os.tmpname() .. ".sh"
		local f = io.open(opener, "w")
		f:write(("#!/bin/sh\nprintf '%%s' \"$1\" > %s\n"):format(elio_selected))
		f:close()
		os.execute(("chmod +x %s"):format(opener))

		local term = Snacks.terminal.open({ "elio", "--cwd-file", elio_cwd }, {
			env = vim.tbl_extend("force", vim.fn.environ(), {
				VISUAL = opener,
				EDITOR = opener,
			}),
		})

		term:on("TermClose", function()
			vim.schedule(function()
				os.remove(opener)

				-- Try to open the selected file
				local sf = io.open(elio_selected, "r")
				os.remove(elio_selected)
				if sf then
					local file = sf:read("*l")
					sf:close()
					if file and file ~= "" and vim.fn.filereadable(file) == 1 then
						vim.cmd("edit " .. vim.fn.fnameescape(file))
						return
					end
				end

				-- No file selected — sync cwd
				local cf = io.open(elio_cwd, "r")
				os.remove(elio_cwd)
				if cf then
					local cwd = cf:read("*l")
					cf:close()
					if cwd and cwd ~= "" then
						vim.cmd("cd " .. vim.fn.fnameescape(cwd))
					end
				end
			end)
		end, { buf = true })
	end)
		:with_noremap()
		:with_silent()
		:with_desc("find: File in cwd (elio preview)"),
}

return plug_map
