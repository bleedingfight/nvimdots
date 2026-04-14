return vim.schedule_wrap(function()
	local use_ssh = require("core.settings").use_ssh
	local treesitter_deps = require("core.settings").treesitter_deps

	-- nvim-treesitter new API (Nvim 0.12+):
	-- setup() only accepts install_dir; highlight/indent are handled by Neovim natively.
	require("nvim-treesitter").setup()

	-- Install parsers (async, no-op if already installed)
	require("nvim-treesitter").install(treesitter_deps)

	require("nvim-treesitter.install").prefer_git = true

	-- SSH mirror for parser downloads
	if use_ssh then
		local parsers_mod = require("nvim-treesitter.parsers")
		if type(parsers_mod) == "table" then
			for _, p in pairs(parsers_mod) do
				if type(p) == "table" and p.install_info and p.install_info.url then
					p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
				end
			end
		end
	end

	-- Enable treesitter highlighting and folding per filetype
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
		callback = function(ev)
			local ft = vim.bo[ev.buf].filetype
			-- Disable for vim filetype and large files
			if vim.tbl_contains({ "vim" }, ft) then
				return
			end
			if vim.b[ev.buf].bigfile then
				return
			end
			local ok = pcall(vim.treesitter.start, ev.buf)
			if ok then
				vim.wo[0][0].foldmethod = "expr"
				vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end
		end,
	})

	-- nvim-treesitter-textobjects new API: keymaps via vim.keymap.set
	local select = require("nvim-treesitter-textobjects.select")
	local move = require("nvim-treesitter-textobjects.move")

	require("nvim-treesitter-textobjects").setup({
		move = { set_jumps = true },
	})

	-- Select text objects
	vim.keymap.set({ "x", "o" }, "af", function()
		select.select_textobject("@function.outer", "textobjects")
	end, { desc = "Select outer function" })
	vim.keymap.set({ "x", "o" }, "if", function()
		select.select_textobject("@function.inner", "textobjects")
	end, { desc = "Select inner function" })
	vim.keymap.set({ "x", "o" }, "ac", function()
		select.select_textobject("@class.outer", "textobjects")
	end, { desc = "Select outer class" })
	vim.keymap.set({ "x", "o" }, "ic", function()
		select.select_textobject("@class.inner", "textobjects")
	end, { desc = "Select inner class" })

	-- Move text objects
	vim.keymap.set({ "n", "x", "o" }, "][", function()
		move.goto_next_start("@function.outer", "textobjects")
	end, { desc = "Next function start" })
	vim.keymap.set({ "n", "x", "o" }, "]m", function()
		move.goto_next_start("@class.outer", "textobjects")
	end, { desc = "Next class start" })
	vim.keymap.set({ "n", "x", "o" }, "]]", function()
		move.goto_next_end("@function.outer", "textobjects")
	end, { desc = "Next function end" })
	vim.keymap.set({ "n", "x", "o" }, "]M", function()
		move.goto_next_end("@class.outer", "textobjects")
	end, { desc = "Next class end" })
	vim.keymap.set({ "n", "x", "o" }, "[[", function()
		move.goto_previous_start("@function.outer", "textobjects")
	end, { desc = "Prev function start" })
	vim.keymap.set({ "n", "x", "o" }, "[m", function()
		move.goto_previous_start("@class.outer", "textobjects")
	end, { desc = "Prev class start" })
	vim.keymap.set({ "n", "x", "o" }, "[]", function()
		move.goto_previous_end("@function.outer", "textobjects")
	end, { desc = "Prev function end" })
	vim.keymap.set({ "n", "x", "o" }, "[M", function()
		move.goto_previous_end("@class.outer", "textobjects")
	end, { desc = "Prev class end" })
end)
