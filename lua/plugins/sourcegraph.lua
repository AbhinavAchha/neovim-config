return {
	"sourcegraph/sg.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },

	-- If you have a recent version of lazy.nvim, you don't need to add this!
	build = "nvim -l build/init.lua",

	opts = {},

	keys = {
		{ "<leader>ts", ":lua require('sg.extensions.telescope').fuzzy_search_results()<CR>" },
	},
}
