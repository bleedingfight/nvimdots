return function()
	local icons = {
		ui = require("modules.utils.icons").get("ui"),
		misc = require("modules.utils.icons").get("misc"),
		git = require("modules.utils.icons").get("git", true),
		cmp = require("modules.utils.icons").get("cmp", true),
	}

	local defs = require("keymap.definitions")
	require("which-key").add(defs.which_key_spec())

	-- User command for keymap search (function defined in keymap/helpers.lua)
	vim.api.nvim_create_user_command("SearchKeymaps", function(opts)
		_search_keymaps(opts.args or "")
	end, { nargs = "?", desc = "Search keymaps by prefix with plugin source" })

	require("modules.utils").load_plugin("which-key", {
		plugins = {
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = true,
				g = true,
			},
		},

		-- Manual triggers for single-letter prefixes that which-key won't auto-detect
		-- (c is Vim's change operator, so which-key skips it by default)
		triggers = {
			{ "<auto>", mode = "nxso" },
			{ "c", mode = "n" },
		},

		icons = {
			breadcrumb = icons.ui.Separator,
			separator = icons.misc.Vbar,
			group = "",
		},

		window = {
			border = "none",
			position = "bottom",
			margin = { 1, 0, 1, 0 },
			padding = { 1, 1, 1, 1 },
			winblend = 0,
		},
	})
end
