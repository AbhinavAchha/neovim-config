local majorCommentType = { __default = "// %s", __multiline = "/* %s */" }

return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	opts = {
		enable = true,
		enable_autocmd = true,
		key = "__multiline",
		config = {
			typescript = majorCommentType,
			typescriptreact = majorCommentType,
			javascript = majorCommentType,
			javascriptreact = majorCommentType,
			go = majorCommentType,
		},
	},
}
