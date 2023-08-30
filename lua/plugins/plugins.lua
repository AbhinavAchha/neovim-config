return {
	"L3MON4D3/LuaSnip",
	"Rigellute/rigel",
	"SmiteshP/nvim-navic",
	"ellisonleao/glow.nvim",
	"kyazdani42/nvim-web-devicons",
	"mhinz/vim-startify",
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	"rafamadriz/friendly-snippets",
	"kylechui/nvim-surround",
	"wakatime/vim-wakatime",
	"dracula/vim",
	"ray-x/guihua.lua", -- recommanded if need floating window support,
	"almo7aya/openingh.nvim",
	"folke/tokyonight.nvim",
	"itchyny/vim-cursorword",
	"jghauser/mkdir.nvim",
	"vuki656/package-info.nvim",
	"norcalli/nvim-colorizer.lua",
	"rmagatti/goto-preview",
	"ray-x/go.nvim",
	"jinh0/eyeliner.nvim",
	"akinsho/toggleterm.nvim",
	"crispgm/nvim-tabline",
	"ethanholz/nvim-lastplace",
	"github/copilot.vim",
	"kyazdani42/nvim-tree.lua",
	"lewis6991/gitsigns.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"mhartington/formatter.nvim",
	"numToStr/Comment.nvim",
	"nvim-lualine/lualine.nvim",
	"nvim-telescope/telescope.nvim",
	"tpope/vim-fugitive",
	"windwp/nvim-autopairs",
	"windwp/nvim-spectre",
	"themaxmarchuk/tailwindcss-colors.nvim",
	"lvimuser/lsp-inlayhints.nvim",
	"MaximilianLloyd/tw-values.nvim",

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"petertriho/cmp-git",
	"hrsh7th/cmp-calc",

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{ "numirias/semshi", build = ":UpdateRemotePlugins" },
	{ "mg979/vim-visual-multi", branch = "master" },

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"nvim-treesitter/nvim-treesitter-context",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/playground",
	"HiPhish/nvim-ts-rainbow2",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"projekt0n/github-nvim-theme",
		config = function()
			require("github-theme").setup()
		end,
	},
}
