vim.api.nvim_create_autocmd("FileType", {
	pattern = "text",
	callback = function()
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		if vim.hl and vim.hl.hl_op then
			vim.hl.hl_op({ timeout = vim.g.highlightedyank_highlight_duration })
		elseif vim.hl and vim.hl.on_yank then
			vim.hl.on_yank({ timeout = vim.g.highlightedyank_highlight_duration })
		end
	end,
})

local lastplace_group = vim.api.nvim_create_augroup("LastPlace", { clear = true })
local lastplace_ignore_buftype = { "quickfix", "nofile", "help" }
local lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

vim.api.nvim_create_autocmd("BufReadPost", {
	group = lastplace_group,
	callback = function(ev)
		local buftype = vim.bo[ev.buf].buftype
		local filetype = vim.bo[ev.buf].filetype
		if vim.tbl_contains(lastplace_ignore_buftype, buftype) or vim.tbl_contains(lastplace_ignore_filetype, filetype) then
			return
		end

		local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(ev.buf)
		if mark[1] < 1 or mark[1] > line_count then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, mark)
		pcall(vim.cmd.normal, { "zv", bang = true })
	end,
})

-- Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(ev)
		vim.keymap.set("i", "<M-p>", "print()<left>", { buf = ev.buf })
	end,
})

-- JavaScript / TypeScript / HTML
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "typescriptreact", "html" },
	callback = function(ev)
		vim.keymap.set("i", "<C-c>", "console.log();<left><left>", { buf = ev.buf })
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
