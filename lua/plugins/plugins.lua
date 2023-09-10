return {
	"Rigellute/rigel",
	"ellisonleao/glow.nvim",
	"mhinz/vim-startify",
	"nvim-lua/popup.nvim",
	"wakatime/vim-wakatime",
	"dracula/vim",
	"almo7aya/openingh.nvim",
	"folke/tokyonight.nvim",
	"itchyny/vim-cursorword",
	"jghauser/mkdir.nvim",
	"themaxmarchuk/tailwindcss-colors.nvim",
	"lvimuser/lsp-inlayhints.nvim",

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	{ "numirias/semshi", build = ":UpdateRemotePlugins" },
	{ "mg979/vim-visual-multi", branch = "master" },

	{
		"projekt0n/github-nvim-theme",
		config = function()
			require("github-theme").setup()
		end,
	},
}
