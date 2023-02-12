local packer = require("packer")

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("L3MON4D3/LuaSnip")
	use("Rigellute/rigel")
	use("SmiteshP/nvim-navic")
	use("ellisonleao/glow.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("mhinz/vim-startify")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("rafamadriz/friendly-snippets")
	use("kylechui/nvim-surround")
	use("wakatime/vim-wakatime")
	use("dracula/vim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support
	use("almo7aya/openingh.nvim")
	use("folke/tokyonight.nvim")
	use("itchyny/vim-cursorword")
	use("jghauser/mkdir.nvim")
	use("vuki656/package-info.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("rmagatti/goto-preview")
	use("ray-x/go.nvim")
	use("jinh0/eyeliner.nvim")
	use("Pocco81/AbbrevMan.nvim")
	use("akinsho/toggleterm.nvim")
	use("crispgm/nvim-tabline")
	use("ethanholz/nvim-lastplace")
	use("github/copilot.vim")
	use("kyazdani42/nvim-tree.lua")
	use("lewis6991/gitsigns.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("mhartington/formatter.nvim")
	use("numToStr/Comment.nvim")
	use("nvim-lualine/lualine.nvim")
	use("nvim-telescope/telescope.nvim")
	use("tpope/vim-fugitive")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-spectre")
	use({ "tjdevries/sg.nvim", run = "cargo build --workspace" })

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("petertriho/cmp-git")
	use("hrsh7th/cmp-calc")

	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "numirias/semshi", run = ":UpdateRemotePlugins" })
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({
		"themaxmarchuk/tailwindcss-colors.nvim",
		-- load only on require("tailwindcss-colors")
		config = function()
			-- pass config options here (or nothing to use defaults)
			require("tailwindcss-colors").setup()
		end,
	})

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-context")
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("nvim-treesitter/playground")
	use("p00f/nvim-ts-rainbow")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use({
		"projekt0n/github-nvim-theme",
		branch = "0.0.x",
		config = function()
			require("github-theme").setup()
		end,
	})
end)
