require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = {},
	highlight = {
		enable = true,
		disable = {
			"html",
		},
	},
	indend = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
		-- colors = {},
		-- termcolors = {},
	},
	autopairs = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},
})
