local custom = {}
custom["kylechui/nvim-surround"] = {
	lazy = true,
	event = "BufRead",
	config = require("custom.nvim-surround"),
}
return custom
