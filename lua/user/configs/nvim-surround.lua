custom["kylechui/nvim-surround"] = {
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}
