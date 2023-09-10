return {
	"MaximilianLloyd/tw-values.nvim",
	config = function()
		require("tw-values").setup({
			opts = {
				border = "rounded",
			},
		})
	end,
}
