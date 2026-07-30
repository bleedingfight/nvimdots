-- Central keymap definitions used by both which-key and _search_keymaps
-- Format: { lhs, mode, desc, plugin }
-- Groups: { lhs, mode, desc, plugin, group=true }

local M = {}

local icons = {
	ui = require("modules.utils.icons").get("ui"),
	misc = require("modules.utils.icons").get("misc"),
	git = require("modules.utils.icons").get("git", true),
	cmp = require("modules.utils.icons").get("cmp", true),
}

local defs = {
	-- <leader>b Buffer
	{ "<leader>b", "n", icons.ui.Buffer .. " Buffer", "bufferline", true },
	{ "<leader>be", "n", "Sort by extension", "bufferline" },
	{ "<leader>bd", "n", "Sort by directory", "bufferline" },
	{ "<leader>bn", "n", "New buffer", "core" },
	-- <leader>d Debug
	{ "<leader>d", "n", icons.ui.Bug .. " Debug", "nvim-dap", true },
	{ "<leader>da", "n", "Clear all breakpoints", "nvim-dap" },
	{ "<leader>de", "n", "Clear current breakpoint", "nvim-dap" },
	{ "<leader>db", "n", "Set conditional breakpoint", "nvim-dap" },
	{ "<leader>dc", "n", "Run to cursor", "nvim-dap" },
	{ "<leader>dl", "n", "Run last", "nvim-dap" },
	{ "<leader>do", "n", "Open REPL", "nvim-dap" },
	-- <leader>f Fuzzy Find
	{ "<leader>f", "n", icons.ui.Telescope .. " Fuzzy Find", "telescope", true },
	{ "<leader>fp", "n", "File in cwd", "telescope" },
	{ "<leader>fr", "n", "File by frecency", "mini.visits" },
	{ "<leader>fw", "n", "Word in project", "telescope-live-grep-args" },
	{ "<leader>fe", "n", "File by history", "telescope" },
	{ "<leader>ff", "n", "File in project", "telescope" },
	{ "<leader>fc", "n", "Change colorscheme", "telescope" },
	{ "<leader>fg", "n", "File in git project", "telescope" },
	{ "<leader>fz", "n", "Change directory (zoxide)", "telescope-zoxide" },
	{ "<leader>fb", "n", "Buffer opened", "telescope" },
	{ "<leader>fs", "n", "Current word", "telescope" },
	{ "<leader>fd", "n", "Session", "telescope-persisted" },
	{ "<leader>fk", "n", "Keymaps by prefix", "telescope" },
	-- <leader>g Git
	{ "<leader>g", "n", icons.git.Git .. " Git", "git", true },
	{ "<leader>gG", "n", "Open git-fugitive", "vim-fugitive" },
	{ "<leader>gg", "n", "Toggle lazygit", "snacks.lazygit" },
	{ "<leader>gs", "n", "Stage hunk", "gitsigns" },
	{ "<leader>gu", "n", "Undo stage hunk", "gitsigns" },
	{ "<leader>gr", "n", "Reset hunk", "gitsigns" },
	{ "<leader>gR", "n", "Reset buffer", "gitsigns" },
	{ "<leader>gp", "n", "Preview hunk", "gitsigns" },
	{ "<leader>gb", "n", "Blame line", "gitsigns" },
	{ "<leader>gd", "n", "Show diff", "diffview" },
	{ "<leader>gD", "n", "Close diff", "diffview" },
	-- <leader>gc Conflict
	{ "<leader>gc", "n", icons.git.Conflict .. " Conflict", "git-conflict", true },
	{ "<leader>gco", "n", "Choose ours (local)", "git-conflict" },
	{ "<leader>gct", "n", "Choose theirs (remote)", "git-conflict" },
	{ "<leader>gcb", "n", "Choose both", "git-conflict" },
	{ "<leader>gcB", "n", "Choose base", "git-conflict" },
	{ "<leader>gc0", "n", "Choose none", "git-conflict" },
	{ "<leader>gcj", "n", "Next conflict", "git-conflict" },
	{ "<leader>gck", "n", "Prev conflict", "git-conflict" },
	{ "<leader>gcl", "n", "List conflicts", "git-conflict" },
	-- <leader>l Lsp
	{ "<leader>l", "n", icons.misc.LspAvailable .. " Lsp", "lspconfig", true },
	{ "<leader>li", "n", "Lsp info", "lspconfig" },
	{ "<leader>lr", "n", "Restart Lsp", "lspconfig" },
	{ "<leader>lx", "n", "Line diagnostic", "lspsaga" },
	-- <leader>n Nvim Tree
	{ "<leader>n", "n", icons.ui.FolderOpen .. " Nvim Tree", "nvim-tree", true },
	{ "<leader>nf", "n", "Find file", "nvim-tree" },
	{ "<leader>nr", "n", "Refresh", "nvim-tree" },
	-- <leader>p Package
	{ "<leader>p", "n", icons.ui.Package .. " Package", "lazy", true },
	{ "<leader>ph", "n", "Show", "lazy" },
	{ "<leader>ps", "n", "Sync", "lazy" },
	{ "<leader>pu", "n", "Update", "lazy" },
	{ "<leader>pi", "n", "Install", "lazy" },
	{ "<leader>pl", "n", "Log", "lazy" },
	{ "<leader>pc", "n", "Check", "lazy" },
	{ "<leader>pd", "n", "Debug", "lazy" },
	{ "<leader>pp", "n", "Profile", "lazy" },
	{ "<leader>pr", "n", "Restore", "lazy" },
	{ "<leader>px", "n", "Clean", "lazy" },
	-- <leader>r Run
	{ "<leader>r", "n", " Run", "sniprun", true },
	{ "<leader>r", "n", "Run code by file", "sniprun" },
	-- <leader>s Session
	{ "<leader>s", "n", icons.cmp.tmux .. " Session", "persisted", true },
	{ "<leader>ss", "n", "Save session", "persisted" },
	{ "<leader>sl", "n", "Load session", "persisted" },
	{ "<leader>sd", "n", "Delete session", "persisted" },
	-- <leader>S Search
	{ "<leader>S", "n", icons.ui.Search .. " Search", "nvim-spectre", true },
	{ "<leader>Ss", "n", "Toggle search & replace panel", "nvim-spectre" },
	{ "<leader>Sp", "n", "Search & replace current word (project)", "nvim-spectre" },
	{ "<leader>Sf", "n", "Search & replace current word (file)", "nvim-spectre" },
	-- <leader>W Window
	{ "<leader>W", "n", icons.ui.Window .. " Window", "smart-splits", true },
	{ "<leader>Wh", "n", "Move window leftward", "smart-splits" },
	{ "<leader>Wj", "n", "Move window downward", "smart-splits" },
	{ "<leader>Wk", "n", "Move window upward", "smart-splits" },
	{ "<leader>Wl", "n", "Move window rightward", "smart-splits" },
	-- <leader> misc
	{ "<leader>u", "n", "Show undo history", "telescope-undo" },
	{ "<leader>w", "n", "Goto word", "hop" },
	{ "<leader>j", "n", "Goto line", "hop" },
	{ "<leader>k", "n", "Goto line", "hop" },
	{ "<leader>c", "n", "Goto one char", "hop" },
	{ "<leader>C", "n", "Goto two chars", "hop" },
	{ "<leader>tt", "n", "Toggle float terminal", "snacks.terminal" },
	-- g Goto
	{ "g", "n", " Goto", "lsp", true },
	{ "go", "n", "Toggle outline", "aerial" },
	{ "g[", "n", "Prev diagnostic", "lspsaga" },
	{ "g]", "n", "Next diagnostic", "lspsaga" },
	{ "gs", "n", "Signature help", "lsp" },
	{ "gr", "n", "Rename in file range", "lspsaga" },
	{ "gR", "n", "Rename in project range", "lspsaga" },
	{ "gd", "n", "Preview definition", "glance" },
	{ "gD", "n", "Goto definition", "lspsaga" },
	{ "gh", "n", "Show reference", "glance" },
	{ "gm", "n", "Show implementation", "glance" },
	{ "gci", "n", "Incoming calls", "lspsaga" },
	{ "gco", "n", "Outgoing calls", "lspsaga" },
	-- c Conflict (buffer-local from git-conflict)
	{ "c", "n", icons.git.Conflict .. " Conflict", "git-conflict", true },
	{ "co", "n", "Choose ours (local)", "git-conflict" },
	{ "ct", "n", "Choose theirs (remote)", "git-conflict" },
	{ "cb", "n", "Choose both", "git-conflict" },
	{ "cB", "n", "Choose base", "git-conflict" },
	{ "c0", "n", "Choose none", "git-conflict" },
}

--- Build which-key spec (v1 format) from definitions
function M.which_key_spec()
	local spec = {}
	for _, d in ipairs(defs) do
		local lhs, mode, desc, plugin, is_group = d[1], d[2], d[3], d[4], d[5]
		local entry = { lhs, desc = desc .. " [" .. plugin .. "]" }
		if is_group then
			entry.group = true
		end
		table.insert(spec, entry)
	end
	return spec
end

--- Get all definitions matching a prefix
function M.search(prefix)
	local results = {}
	for _, d in ipairs(defs) do
		local lhs, mode, desc, plugin, is_group = d[1], d[2], d[3], d[4], d[5]
		if prefix == "" or vim.startswith(lhs, prefix) then
			table.insert(results, {
				mode = mode,
				lhs = lhs,
				desc = desc,
				plugin = plugin,
				is_group = is_group or false,
				display_lhs = lhs:gsub("<[Ll]eader>", vim.g.map_leader or " "),
			})
		end
	end
	return results
end

return M
