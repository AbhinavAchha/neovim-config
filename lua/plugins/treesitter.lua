return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"hiphish/rainbow-delimiters.nvim",
	},
	build = ":TSUpdate",

	config = function()
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
			autopairs = {
				enable = true,
			},
		})

		-- This module contains a number of default definitions
		local rainbow_delimiters = require("rainbow-delimiters")

		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}
	end,
}
