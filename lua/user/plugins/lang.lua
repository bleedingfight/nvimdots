local lang = {}

lang["mrcjkb/rustaceanvim"] = {
	lazy = true,
	ft = "rust",
	version = "^3",
	init = require("lang.rust"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
return lang
