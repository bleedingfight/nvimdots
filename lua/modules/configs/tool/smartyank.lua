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
			-- 内置 osc52 经 `chansend(vim.v.stderr)` 发送, 在 mac->ubuntu ssh 会话里 stderr 通道
			-- 不通到 mac, 序列到不了本地剪贴板。改用下方自定义 action 走 io.stdout。
			enabled = false,
			ssh_only = true, -- false to OSC52 yank also in local sessions 需要设置SSH_CONNECTION
			silent = false, -- true to disable the "n chars copied" echo
			echo_hl = "Directory", -- highlight group of the OSC52 echo message
		},
		-- 自定义 osc52 action: 走 io.stdout (实测 mac->ubuntu ssh 会话里 stdout 能到 mac 剪贴板,
		-- 而 chansend(vim.v.stderr) 不能)。覆盖内置 osc52 失效后的发送路径。
		actions = {
			{
				cond = function(valid)
					-- 没有可用的本地剪贴板提供方时, 才用 osc52 经终端把内容送到客户端剪贴板。
					-- 比 SSH_CONNECTION 判断更准: 同时覆盖「远程 ssh」和「本机纯 tty 无桌面」两种
					-- 没有本地剪贴板的场景; 而本机有桌面(has('clipboard')==1)时走系统剪贴板。
					-- 适用于 mac/linux 任意客户端, 只要其终端支持 osc52(kitty/wezterm/foot 默认支持)。
					return valid and vim.fn.has("clipboard") == 0
				end,
				yank = function(str)
					local b64 = require("smartyank.base64").encode(str)
					local seq = string.format("\x1b]52;c;%s\x07", b64)
					io.stdout:write(seq)
					io.stdout:flush()
					local msg = string.format("[smartyank] %d chars copied using OSC52 (stdout)", #str)
					vim.api.nvim_echo({ { msg, "Directory" } }, false, {})
				end,
			},
		},
	})
end
