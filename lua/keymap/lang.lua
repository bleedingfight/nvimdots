local bind = require("keymap.bind")
local map_cr = bind.map_cr
-- local map_cu = bind.map_cu
-- local map_cmd = bind.map_cmd
-- local map_callback = bind.map_callback

local plug_map = {
	-- Plugin MarkdownPreview
	["n|<F12>"] = map_cr("MarkdownPreviewToggle"):with_noremap():with_silent():with_desc("tool: Preview markdown"),

	-- Rust (rustaceanvim)
	["n|<leader>rd"] = map_cr("RustLsp debuggables"):with_noremap():with_silent():with_desc("rust: Debug"),
	["n|<leader>rr"] = map_cr("RustLsp runnables"):with_noremap():with_silent():with_desc("rust: Run"),
	["n|<leader>rt"] = map_cr("RustLsp testables"):with_noremap():with_silent():with_desc("rust: Test"),
	["n|<leader>re"] = map_cr("RustLsp explainError"):with_noremap():with_silent():with_desc("rust: Explain error"),
	["n|<leader>rc"] = map_cr("RustLsp openCargo"):with_noremap():with_silent():with_desc("rust: Open Cargo.toml"),
	["n|<leader>rp"] = map_cr("RustLsp parentModule"):with_noremap():with_silent():with_desc("rust: Parent module"),
}

bind.nvim_load_mapping(plug_map)
