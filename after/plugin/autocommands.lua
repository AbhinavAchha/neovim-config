vim.api.nvim_create_autocmd("FileType", {
	pattern = "text",
	callback = function()
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set("i", "<M-p>", "print()<left>", { buffer = true })
	end,
})

-- JavaScript / TypeScript / HTML
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "typescriptreact", "html" },
	callback = function()
		vim.keymap.set("i", "<C-c>", "console.log();<left><left>", { buffer = true })
	end,
})

-- Create a group so it doesn't duplicate if you source your config multiple times
local justfile_group = vim.api.nvim_create_augroup("JustfileSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "just",
	group = justfile_group,
	callback = function()
		vim.opt_local.expandtab = false -- Force tabs instead of spaces
		vim.opt_local.tabstop = 4 -- Visual width of a tab
		vim.opt_local.shiftwidth = 4 -- Size of an indent
	end,
})

------------------------------
-- " => Colorscheme section
------------------------------

local function set_colors()
	vim.api.nvim_set_hl(0, "@string", { ctermfg = 228, fg = "#f1fa8c", bold = true })
	vim.api.nvim_set_hl(0, "@keyword", { ctermfg = 228, fg = "#30baf8", bold = true })
	vim.api.nvim_set_hl(0, "@function", { ctermfg = 228, fg = "#ffe1ff", bold = true })
	vim.api.nvim_set_hl(0, "@function.builtin", { ctermfg = 228, fg = "#ffe1ff", italic = true })
	vim.api.nvim_set_hl(0, "@constant", { ctermfg = 228, fg = "#ff79c6", italic = true, bold = true })
	vim.api.nvim_set_hl(0, "@constant.builtin", { ctermfg = 228, fg = "#ff79c6", bold = true })
	vim.api.nvim_set_hl(0, "@property", { ctermfg = 228, fg = "#98ff98", italic = true })
	vim.api.nvim_set_hl(0, "@boolean", { ctermfg = 228, fg = "#ab92b3", italic = true, bold = true })
	vim.api.nvim_set_hl(0, "@tag", { ctermfg = 228, fg = "#bbff99", italic = true, bold = true })
	vim.api.nvim_set_hl(0, "@keyword.import", { ctermfg = 228, fg = "#12e781", italic = true, bold = true })
	vim.api.nvim_set_hl(0, "@variable.parameter", { ctermfg = 228, italic = true })
	vim.api.nvim_set_hl(0, "@type", { bold = true, fg = "#ffa69e" })
	vim.api.nvim_set_hl(0, "@module", { ctermfg = 228, italic = true, bold = true })
	vim.api.nvim_set_hl(0, "@function.method", { ctermfg = 228, bold = true })
	vim.api.nvim_set_hl(0, "@function.method.call", { ctermfg = 228, bold = true })
	vim.api.nvim_set_hl(0, "@comment", { ctermfg = 228, fg = "#999999", italic = true })
	vim.api.nvim_set_hl(0, "@keyword.repeat", { bold = true, fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "@operator", { bold = true, fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "@number", { bold = true, fg = "#ffffff" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_colors,
})

set_colors()
