return {
	"m4xshen/hardtime.nvim",
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {
		disabled_filetypes = { "NvimTree", "Trouble", "Outline", "help", "query" },
		max_time = 500,
		disable_mouse = false,
		restriction_mode = "hint",
		disabled_keys = {
			["<Up>"] = { "" },
			["<Down>"] = { "" },
			["<Left>"] = { "" },
			["<Right>"] = { "" },
		},
	},
}
