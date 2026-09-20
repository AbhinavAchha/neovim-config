return {
	"catgoose/nvim-colorizer.lua",
	opts = {
		filetypes = {
			"*",
			css = { rgb_fn = true, names = true },
			html = { names = true },
		},
	},
	init = function()
		vim.opt.termguicolors = true
	end,
}
