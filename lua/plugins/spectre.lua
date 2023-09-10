return {
	"windwp/nvim-spectre",

	keys = {
		{ "<leader>S", ":lua require('spectre').open()<CR>" },
		{ "<leader>SV", ":lua require('spectre').open_visual()<CR>" },
	},
}
