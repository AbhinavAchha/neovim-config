require("tabline").setup({
	show_icon = true,
})

-- https://stackoverflow.com/a/7238163/14547900
vim.cmd([[
hi TabLine guibg=#bcbcbc
hi TabLineSel guibg=#2aa5a5
]])
