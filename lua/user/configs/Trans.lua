return function() -- This file MUST return a function accepting no parameter and has no return value
	require("Trans").setup({
		frontend = {
			hover = {
				keymaps = {
					-- pageup       = 'whatever you want',
					-- pagedown     = 'whatever you want',
					-- pin          = 'whatever you want',
					-- close        = 'whatever you want',
					-- toggle_entry = 'whatever you want',
				},
			},
		},
	})
end
