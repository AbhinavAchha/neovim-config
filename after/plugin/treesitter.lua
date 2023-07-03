local majorCommentType = { __default = "// %s", __multiline = "/* %s */" }

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
		query = "rainbow-parens",
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
