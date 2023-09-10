return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"nvim-telescope/telescope.nvim", -- optional
		"sindrets/diffview.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	config = function()
		require("neogit").setup({
			disable_hint = true,
			disable_commit_confirmation = true,
		})
	end,
	keys = {
		{ "<leader>gd", "<cmd>Neogit diff<CR>" },
		{ "<leader>gl", "<cmd>Neogit log<CR>" },
		{ "<leader>gp", "<cmd>Neogit push<CR>" },
		{ "<leader>gpf", "<cmd>Neogit push --force<CR>" },
		{ "<leader>G", "<cmd>Neogit<CR>" },
		{ "<leader>gD", "<cmd>Neogit diff %<CR>" },
	},
}
