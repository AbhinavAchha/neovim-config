return {
	"norcalli/nvim-colorizer.lua",
	opts = {
		"*", -- Highlight all files, but customize some others.
		css = { rgb_fn = true, names = true }, -- Enable parsing rgb(...) functions in css.
		html = { names = true }, -- Disable parsing "names" like Blue or Gray
	},
	init = function()
		vim.opt.termguicolors = true
	end,
}
