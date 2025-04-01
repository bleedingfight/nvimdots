local custom = {}

custom["folke/todo-comments.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.todo-comments"),
}

custom["olimorris/codecompanion.nvim"] = {
	lazy = true,
	event = "BufRead",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = require("configs.editor.codecompanion"),
}

custom["akinsho/git-conflict.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.git-conflict"),
}

custom["folke/snacks.nvim"] = {
	lazy = false,
	event = "BufRead",
	config = require("configs.editor.snacks"),
}

custom["MeanderingProgrammer/render-markdown.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.render-markdown"),
}

custom["lewis6991/hover.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.hover"),
}

custom["nvim-mini/mini.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.nvim-mini"),
}

return custom
