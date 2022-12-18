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
	use("nvim-treesitter/playground")
	use("p00f/nvim-ts-rainbow")
	-- use("pechorin/any-jump.vim")
	use("rafamadriz/friendly-snippets")
	use("tpope/vim-surround")
	-- use("MunifTanjim/nui.nvim")
	use("wakatime/vim-wakatime")
	use("dracula/vim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support
	use("almo7aya/openingh.nvim")
	use("folke/tokyonight.nvim")
	use("itchyny/vim-cursorword")
	use("jghauser/mkdir.nvim")
	use("eandrju/cellular-automaton.nvim")
	use("vuki656/package-info.nvim")
	use("norcalli/nvim-colorizer.lua")
	use("rmagatti/goto-preview")
	use("nvim-treesitter/nvim-treesitter-context")
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
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")
	use("nvim-lualine/lualine.nvim")
	use("nvim-telescope/telescope.nvim")
	use("tpope/vim-fugitive")
	use("windwp/nvim-autopairs")

	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("David-Kunz/cmp-npm")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use({ "petertriho/cmp-git" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })

	use({ "kartikp10/noctis.nvim", requires = { "rktjmp/lush.nvim" } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "numirias/semshi", run = ":UpdateRemotePlugins" })
	use({ "mg979/vim-visual-multi", branch = "master" })
	-- use({ "ray-x/lsp_signature.nvim", config = require("nvim_lsp_signature") })
	-- use({ "folke/styler.nvim", config = require("styler_config") })
end)
