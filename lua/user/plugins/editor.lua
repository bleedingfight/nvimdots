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
	config = require("configs.editor.todo-comments"), -- Require that config
}

custom["lervag/vimtex"] = {
	lazy = false,
	event = "BufRead",
	config = require("configs.editor.todo-comments"), -- Require that config
}
return custom
