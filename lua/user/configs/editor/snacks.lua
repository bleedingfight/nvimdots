return function()
	require("snacks").setup({
		bigfile = {
			size = 1 * 1024 * 1024, -- 1MB, matches previous bigfile.nvim config
			notify = true,
			setup = function(ctx)
				vim.b[ctx.buf].bigfile = true
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then
						vim.bo[ctx.buf].syntax = ctx.ft
					end
				end)
				-- disable nvim-cmp for big files
				pcall(function()
					require("cmp").setup.buffer({ enabled = false })
				end)
			end,
		},
		bufdelete = { enabled = true },
	})
end
