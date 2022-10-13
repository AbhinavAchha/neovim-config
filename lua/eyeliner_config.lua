require("eyeliner").setup({
	highlight_on_key = true,
})
vim.api.nvim_set_hl(0, "EyelinerPrimary", { fg = "#000000", bold = true, underline = true })
vim.api.nvim_set_hl(0, "EyelinerSecondary", { fg = "#ffffff", underline = true })
