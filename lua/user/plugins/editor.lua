local custom = {}

custom["kylechui/nvim-surround"] = {
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}

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
	lazy = true,
	event = "BufRead",
	config = require("configs.editor.snacks"),
}
return custom
