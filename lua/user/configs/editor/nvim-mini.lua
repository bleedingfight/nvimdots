return function()
	require("mini.statusline").setup({
		-- Content of statusline as functions which return statusline string. See
		-- `:h statusline` and code of default contents (used instead of `nil`).
		content = {
			-- Content for active window
			active = nil,
			-- Content for inactive window(s)
			inactive = nil,
		},

		-- Whether to set Vim's settings for statusline (make it always shown with
		-- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
		-- this to `false` and 'laststatus' to 3.
		set_vim_settings = true,
	})
	require("mini.tabline").setup({
		{
			-- Whether to show file icons (requires 'mini.icons')
			show_icons = true,

			-- Function which formats the tab label
			-- By default surrounds with space and possibly prepends with icon
			format = nil,

			-- Where to show tabpage section in case of multiple vim tabpages.
			-- One of 'left', 'right', 'none'.
			tabpage_section = "left",
		},
	})
	require("mini.icons").setup({
		-- Icon style: 'glyph' or 'ascii'
		style = "glyph",

		-- Customize per category. See `:h MiniIcons.config` for details.
		default = {},
		directory = {},
		extension = {},
		file = {},
		filetype = {},
		lsp = {},
		os = {},

		-- Control which extensions will be considered during "file" resolution
		use_file_extension = function(_ext, _file)
			return true
		end,
	})
	require("mini.diff").setup({
		-- Options for how hunks are visualized
		view = {
			-- Visualization style. Possible values are 'sign' and 'number'.
			-- Default: 'number' if line numbers are enabled, 'sign' otherwise.
			style = vim.go.number and "number" or "sign",

			-- Signs used for hunks with 'sign' view
			signs = { add = "▒", change = "▒", delete = "▒" },

			-- Priority of used visualization extmarks
			priority = 199,
		},

		-- Source(s) for how reference text is computed/updated/etc
		-- Uses content from Git index by default
		source = nil,

		-- Delays (in ms) defining asynchronous processes
		delay = {
			-- How much to wait before update following every text change
			text_change = 200,
		},

		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			-- Apply hunks inside a visual/operator region
			apply = "gh",

			-- Reset hunks inside a visual/operator region
			reset = "gH",

			-- Hunk range textobject to be used inside operator
			-- Works also in Visual mode if mapping differs from apply and reset
			textobject = "gh",

			-- Go to hunk range in corresponding direction
			goto_first = "[H",
			goto_prev = "[h",
			goto_next = "]h",
			goto_last = "]H",
		},

		-- Various options
		options = {
			-- Diff algorithm. See `:h vim.diff()`.
			algorithm = "histogram",

			-- Whether to use "indent heuristic". See `:h vim.diff()`.
			indent_heuristic = true,

			-- The amount of second-stage diff to align lines
			linematch = 60,

			-- Whether to wrap around edges during hunk navigation
			wrap_goto = false,
		},
	})
	require("mini.surround").setup(
		-- No need to copy this inside `setup()`. Will be used automatically.
		{
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,

			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				add = "ysiw", -- Add surrounding in Normal and Visual modes
				delete = "ds", -- Delete surrounding
				find = "fs", -- Find surrounding (to the right)
				find_left = "Fs", -- Find surrounding (to the left)
				highlight = "hs", -- Highlight surrounding
				replace = "rs", -- Replace surrounding
				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,

			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = "nearest",

			-- Whether to disable showing non-error feedback
			-- This also affects (purely informational) helper messages shown after
			-- idle time if user input is required.
			silent = false,
		}
	)
end
