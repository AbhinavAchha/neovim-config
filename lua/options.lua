local options = {
	autoindent = true,
	so = 7,
	encoding = utf8,
	laststatus = 2,
	ffs = "unix",
	nu = true,
	relativenumber = true,
	writebackup = false,
	smartcase = true,
	smartindent = true,
	timeoutlen = 1000,
	termguicolors = true,
	showtabline = 2,
	undofile = true,
	showmode = false,
	hlsearch = false,
	signcolumn = "yes",
	report = 0,
	autowrite = true,
	foldenable = false,
	backup = false,
	expandtab = true,
	smarttab = true,
	shiftwidth = 4,
	tabstop = 4,
	lbr = true,
	tw = 500,
	si = true,
	wrap = true,
	wb = false,
	swapfile = false,
	history = 5000,
	autoread = true,
	wildmenu = true,
	hid = false,
	ignorecase = true,
	incsearch = true,
	lazyredraw = true,
	magic = true,
	showmatch = true,
	mat = 2,
	errorbells = false,
	visualbell = false,
	tm = 500,
	foldcolumn = "1",
	cursorline = true,
	inccommand = "nosplit",
	secure = true,
	clipboard = "unnamedplus",
	ic = true,
	splitbelow = true,
	splitright = true,
	whichwrap = "<,>,h,l",
	background = "dark",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[set iskeyword +=-]])

vim.cmd([[let g:glow_binary_path = expand("$HOME/.bin")]])

-- vim.cmd([[colorscheme rigel]])
-- vim.cmd([[colorscheme duskfox]])
-- vim.cmd([[colorscheme kanagawa]])
vim.cmd([[colorscheme dracula]])

vim.g.highlightedyank_highlight_duration = 200.
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
