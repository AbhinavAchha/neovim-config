return {
	"chrisgrieser/nvim-puppeteer",
	dependencies = "nvim-treesitter/nvim-treesitter",
	lazy = false, -- plugin lazy-loads itself. Can also load on filetypes.
	init = function()
		vim.g.puppeteer_js_quotation_mark = "'"
	end,
}
