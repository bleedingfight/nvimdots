return function()
	require("modules.utils").load_plugin("smartyank", {
		highlight = {
			enabled = false, -- highlight yanked text
			higroup = "IncSearch", -- highlight group of yanked text
			timeout = 2000, -- timeout for clearing the highlight
		},
		clipboard = {
			enabled = true,
		},
		tmux = {
			enabled = true,
			-- remove `-w` to disable copy to host client's clipboard
			cmd = { "tmux", "set-buffer", "-w" },
		},
		osc52 = {
			enabled = true,
			ssh_only = true, -- false to OSC52 yank also in local sessions 需要设置SSH_CONNECTION
			silent = false, -- true to disable the "n chars copied" echo
			echo_hl = "Directory", -- highlight group of the OSC52 echo message
		},
	})
end
