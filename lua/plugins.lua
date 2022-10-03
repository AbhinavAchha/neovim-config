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
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("L3MON4D3/LuaSnip")
	use("Pocco81/ISuckAtSpelling.nvim")
	use("Rigellute/rigel")
	use("SmiteshP/nvim-gps")
	use("ellisonleao/glow.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("machakann/vim-highlightedyank")
	use("mhinz/vim-startify")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-treesitter/playground")
	use("p00f/nvim-ts-rainbow")
	use("pechorin/any-jump.vim")
	use("rafamadriz/friendly-snippets")
	use("tamago324/nlsp-settings.nvim")
	use("tpope/vim-surround")
	use("MunifTanjim/nui.nvim")
	use("wakatime/vim-wakatime")
	use("dracula/vim")
	use("ray-x/guihua.lua") -- recommanded if need floating window support

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("David-Kunz/cmp-npm")
	use({ "petertriho/cmp-git", config = require("completion_git") })
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")

	use({ "akinsho/toggleterm.nvim", config = require("toggleterm_config") })
	use({ "crispgm/nvim-tabline", config = require("tabline").setup({}) })
	use({ "ethanholz/nvim-lastplace", config = require("nvim_lastplace") })
	use({ "github/copilot.vim", config = require("copilot_config") })
	use({ "kyazdani42/nvim-tree.lua", config = require("nvimtree") })
	use({ "lewis6991/gitsigns.nvim", config = require("gitsigns_config") })
	use({ "lukas-reineke/indent-blankline.nvim", config = require("indent_blankline") })
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({ "mhartington/formatter.nvim", config = require("formatting") })
	use({ "numToStr/Comment.nvim", config = require("comments") })
	use({ "numirias/semshi", run = ":UpdateRemotePlugins" })
	use({ "nvim-lualine/lualine.nvim", config = require("statusline") })
	use({ "nvim-telescope/telescope.nvim", config = require("telescope_config") })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = require("treesitter_config") })
	use({ "tpope/vim-fugitive", config = require("git-keymaps") })
	use({ "windwp/nvim-autopairs", config = require("autopairs") })
	use({ "ray-x/lsp_signature.nvim", config = require("nvim_lsp_signature") })
	use({ "vuki656/package-info.nvim", config = require("package_info_config") })
	use({ "norcalli/nvim-colorizer.lua", config = require("colorizer_config") })
	use({ "rmagatti/goto-preview", config = require("goto_preview_config") })
	use({ "nvim-treesitter/nvim-treesitter-context", config = require("treesitter_context") })
	use({ "ray-x/go.nvim", config = require("go_config") })
end)
