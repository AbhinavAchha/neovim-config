return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		-- https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#padded-full-menu-in-norcallis-blue
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				winblend = 10,
				layout_config = {
					width = 0.9,
					height = 0.9,
				},
				show_line = true,
			},
			builtins = {
				sort_mru = true,
			},
		})
		local TelescopePrompt = {
			TelescopePromptBorder = {
				fg = "#00ff00",
			},
			TelescopePromptTitle = {
				fg = "#dddddd",
				bg = "#000000",
			},
			TelescopePreviewBorder = {
				fg = "#ff00ff",
			},
			TelescopePreviewTitle = {
				fg = "#ff00f0",
				bg = "#000000",
			},
			TelescopeResultsBorder = {
				fg = "#0000ff",
			},
			TelescopeResultsTitle = {
				fg = "#000fff",
				bg = "#000000",
			},
			TelescopeSelectionCaret = {
				fg = "#D79921",
				bold = true,
			},
			TelescopeSelection = {
				fg = "#D79921",
				bold = true,
			},
		}
		for hl, col in pairs(TelescopePrompt) do
			vim.api.nvim_set_hl(0, hl, col)
		end

		telescope.load_extension("fzf")
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
		{ "<leader>ds", ":Telescope lsp_document_symbols<cr>" },
		{ "<leader>dw", ":Telescope lsp_dynamic_workspace_symbols<cr>" },
		{ "<leader>fb", ":Telescope buffers<cr>" },
		{ "<leader>bf", ":Telescope current_buffer_fuzzy_find<cr>" },
		{ "<leader>o", ":Telescope lsp_outgoing_calls<cr>" },
	},
}
