return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"HiPhish/nvim-ts-rainbow2",
	},
	build = ":TSUpdate",

	config = function()
		local majorCommentType = { __default = "// %s", __multiline = "/* %s */" }

		-- check if filetype is typescriptreact or javascriptreact and set query to rainbow-parens-react else rainbow-parens
		local function get_query()
			local extension = vim.fn.expand("%"):match("%.[^.]*$")
			if extension == ".tsx" or extension == ".jsx" then
				return "rainbow-parens-react"
			end
			return "rainbow-parens"
		end

		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			ignore_install = {},
			highlight = {
				enable = true,
				disable = {
					"html",
				},
			},
			indend = {
				enable = true,
			},
			rainbow = {
				enable = true,
				extended_mode = true,
				max_file_lines = nil,
				query = get_query(),
				-- Highlight the entire buffer all at once
				strategy = require("ts-rainbow").strategy.global,
				-- colors = {},
				-- termcolors = {},
			},
			autopairs = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = true,
				config = {
					typescript = majorCommentType,
					typescriptreact = majorCommentType,
					javascript = majorCommentType,
					javascriptreact = majorCommentType,
					go = majorCommentType,
				},
			},
		})
	end,
}
