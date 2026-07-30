_G._command_panel = function()
	require("telescope.builtin").keymaps({
		lhs_filter = function(lhs)
			return not string.find(lhs, "Þ")
		end,
		layout_config = {
			width = 0.6,
			height = 0.6,
			prompt_position = "top",
		},
	})
end

_G._flash_esc_or_noh = function()
	local flash_active, state = pcall(function()
		return require("flash.plugins.char").state
	end)
	if flash_active and state then
		state:hide()
	else
		pcall(vim.cmd.noh)
	end
end

local _lazygit = nil
_G._toggle_lazygit = function()
	if vim.fn.executable("lazygit") == 1 then
		if not _lazygit then
			_lazygit = require("toggleterm.terminal").Terminal:new({
				cmd = "lazygit",
				direction = "float",
				close_on_exit = true,
				hidden = true,
			})
		end
		_lazygit:toggle()
	else
		vim.notify("Command [lazygit] not found!", vim.log.levels.ERROR, { title = "toggleterm.nvim" })
	end
end

-- Enhanced keymap search: show all keymaps matching a prefix with plugin source
_G._search_keymaps = function(prefix)
	local keymaps = {}
	local modes = { "n", "v", "x", "s", "o", "i", "c", "t" }

	-- 1. Collect actual keymaps from Neovim
	for _, mode in ipairs(modes) do
		for _, km in ipairs(vim.api.nvim_get_keymap(mode)) do
			if prefix == "" or vim.startswith(km.lhs, prefix) then
				table.insert(keymaps, {
					mode = mode,
					lhs = km.lhs,
					rhs = km.rhs or "",
					desc = km.desc or "",
					buffer = nil,
					sid = km.sid,
				})
			end
		end
		for _, km in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do
			if prefix == "" or vim.startswith(km.lhs, prefix) then
				table.insert(keymaps, {
					mode = mode,
					lhs = km.lhs,
					rhs = km.rhs or "",
					desc = km.desc or "",
					buffer = km.buffer,
					sid = km.sid,
				})
			end
		end
	end

	-- Resolve plugin name from script ID
	for _, km in ipairs(keymaps) do
		if km.sid and km.sid > 0 then
			local ok, source = pcall(vim.fn.expand, "<sid" .. km.sid .. ">")
			if ok and source ~= "" then
				local plugin = source:match("/([^/]+)/lua/")
					or source:match("/([^/]+)/plugin/")
					or source:match("/([^/]+)/after/")
				km.plugin = plugin or "?"
			end
		end
		if not km.plugin then
			km.plugin = "?"
		end
		km.display_lhs = km.lhs:gsub("<[Ll]eader>", vim.g.map_leader or " ")
	end

	-- 2. Supplement with definitions from keymap/definitions.lua
	-- This provides entries for conditional/buffer-local keymaps (like git-conflict)
	-- that don't always exist as real keymaps
	local defs = require("keymap.definitions")
	for _, d in ipairs(defs.search(prefix)) do
		local already_exists = false
		for _, km in ipairs(keymaps) do
			if km.lhs == d.lhs and km.mode == d.mode then
				-- Enrich actual keymap's desc if it's empty
				if km.desc == "" and d.desc then
					km.desc = d.desc .. " [" .. d.plugin .. "]"
				end
				already_exists = true
				break
			end
		end
		if not already_exists and not d.is_group then
			table.insert(keymaps, {
				mode = d.mode,
				lhs = d.lhs,
				rhs = "",
				desc = d.desc .. " [" .. d.plugin .. "]",
				plugin = d.plugin,
				display_lhs = d.display_lhs,
			})
		end
	end

	-- Deduplicate by (mode, lhs)
	local seen = {}
	local unique = {}
	for _, km in ipairs(keymaps) do
		local key = km.mode .. "|" .. km.lhs
		if not seen[key] then
			seen[key] = true
			table.insert(unique, km)
		end
	end

	table.sort(unique, function(a, b)
		return a.lhs < b.lhs
	end)

	-- 3. Telescope picker
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local entry_display = require("telescope.pickers.entry_display")

	local displayer = entry_display.create({
		separator = " │ ",
		items = {
			{ width = 3 },
			{ width = 22 },
			{ width = 22 },
			{ remaining = true },
		},
	})

	local function make_entry(km)
		return {
			value = km,
			display = function(entry)
				return displayer({
					{ entry.value.mode, "TelescopeResultsIdentifier" },
					{ entry.value.display_lhs, "TelescopeResultsConstant" },
					{ entry.value.plugin or "?", "TelescopeResultsType" },
					{ entry.value.desc, "TelescopeResultsComment" },
				})
			end,
			ordinal = km.display_lhs .. " " .. (km.plugin or "?") .. " " .. km.desc,
		}
	end

	pickers
		.new({}, {
			prompt_title = "Keymaps" .. (prefix ~= "" and (" matching: " .. prefix) or ""),
			finder = finders.new_table({
				results = unique,
				entry_maker = make_entry,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection and selection.value.rhs ~= "" then
						local key = vim.api.nvim_replace_termcodes(selection.value.lhs, true, true, true)
						vim.api.nvim_feedkeys(key, selection.value.mode, false)
					end
				end)
				return true
			end,
		})
		:find()
end

-- TODO: Update this function to use `vim.getregion()` when v0.10 is released.
_G._buf_vtext = function()
	local a_orig = vim.fn.getreg("a")
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		vim.cmd([[normal! gv]])
	end
	vim.cmd([[silent! normal! "aygv]])
	local text = vim.fn.getreg("a")
	vim.fn.setreg("a", a_orig)
	return text
end
