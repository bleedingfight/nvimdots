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
		"ravitemer/mcphub.nvim",
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
	ft = { "markdown", "codecompanion" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-mini/mini.nvim",
	},
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

custom["echasnovski/mini.pick"] = {
	lazy = true,
	version = "*",
	config = function()
		require("mini.pick").setup()
	end,
}

custom["echasnovski/mini.extra"] = {
	lazy = true,
	version = "*",
	config = function()
		require("mini.extra").setup()
	end,
}

custom["HakonHarnes/img-clip.nvim"] = {
	VeryLazy = true,
	event = "BufRead",
	config = require("configs.editor.img-clip"),
}

custom["Furkanzmc/zettelkasten.nvim"] = {
	VeryLazy = true,
	event = "BufRead",
	config = require("configs.editor.zettelkasten"),
}

return custom
