return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-telescope/telescope-fzf-native.nvim",
	},

	config = function()
		require("telescope").load_extension("fzf")
	end,

	keys = {
		{ "<leader>ff", ":Telescope fd<CR>" },
		{ "<leader>rg", ":Telescope live_grep<CR>" },
		{ "<leader>fgc", ":Telescope git_commits<cr>" },
		{ "<leader>fgs", ":Telescope git_status<cr>" },
		{ "<leader>fm", ":Telescope man_pages<cr>" },
		{ "<leader>/", ":Telescope search_history<cr>" },
		{ "<leader>:", ":Telescope command_history<cr>" },
		{ "<leader>k", ":Telescope keymaps<cr>" },
		{ "<leader>gs", ":Telescope grep_string<cr>" },
	},
}
