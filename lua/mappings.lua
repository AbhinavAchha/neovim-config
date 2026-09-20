local opts = { noremap = true, silent = true }
local function nmap(key, cmd)
	vim.keymap.set("n", key, cmd, opts)
end

nmap("0", "^")
nmap("<leader>w", ":w<cr>")
nmap("'", "`")
nmap("<leader>e", ":e%<cr>")
nmap("<leader>A", "ggVG")
nmap("Q", "<NOP>")
nmap("<leader>v", ":vsp<CR>")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("<leader>.", ":cd ..<CR>")

nmap("<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<leader>m", ":set mouse=", { noremap = true })

nmap("<C-t>", ":tabnew<cr>")
nmap("<leader>z", ":tab split<cr>")
nmap("qq", ":q<cr>")
nmap("j", "gj")
nmap("k", "gk")
nmap("<leader>c", ":cclose<CR>")

nmap("<leader>1", "1gt")
nmap("<leader>`", "1gt")
nmap("<leader>2", "2gt")
nmap("<leader>3", "3gt")
nmap("<leader>4", "4gt")
nmap("<leader>5", "5gt")
nmap("<leader>6", "6gt")
nmap("<leader>7", "7gt")
nmap("<leader>8", "8gt")
nmap("<leader>9", "9gt")
nmap("<leader>0", "10gt")
nmap("H", "gT")
nmap("L", "gt")

nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

nmap("<C-Up>", ":resize -1<cr>")
nmap("<C-Down>", ":resize +1<cr>")
nmap("<C-Left>", ":vertical resize -1<cr>")
nmap("<C-Right>", ":vertical resize +1<cr>")

nmap("<M-j>", "mz:m+<cr>`z")
nmap("<M-k>", "mz:m-2<cr>`z")

nmap("-", ":tabm -1<cr>")
nmap("=", ":tabm +1<cr>")
nmap("U", "<C-r>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

vim.keymap.set("v", "<C-s>", ":'<,'>sort<cr>", opts)
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", opts)
vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", opts)
vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)
vim.keymap.set("v", "p", '"_dP', opts)

vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Format buffer" })

vim.keymap.set("v", "<leader>lf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { noremap = true, silent = true, desc = "Format selection" })

vim.cmd([[
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Wqa wqa
cnoreabbrev WQa wqa
]])

local function comment_parts()
	local commentstring = vim.bo.commentstring
	if commentstring == "" then
		local ok, ft_commentstring = pcall(vim.filetype.get_option, vim.bo.filetype, "commentstring")
		if ok and type(ft_commentstring) == "string" then
			commentstring = ft_commentstring
		end
	end

	local before, after = commentstring:match("^(.-)%%s(.*)$")
	if before then
		return before, after
	end

	return "# ", ""
end

local function comment_indent()
	return vim.api.nvim_get_current_line():match("^%s*") or ""
end

local function open_comment_line(direction)
	local before, after = comment_parts()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local insert_at = direction == "below" and row or row - 1
	local indent = comment_indent()
	local line = indent .. before .. after

	vim.api.nvim_buf_set_lines(0, insert_at, insert_at, false, { line })
	vim.api.nvim_win_set_cursor(0, { insert_at + 1, #indent + #before })
	vim.cmd.startinsert()
end

vim.keymap.set("n", "gco", function()
	open_comment_line("below")
end, { desc = "Comment: line below" })

vim.keymap.set("n", "gcO", function()
	open_comment_line("above")
end, { desc = "Comment: line above" })

vim.keymap.set("n", "gcA", function()
	local before, after = comment_parts()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local line = vim.api.nvim_get_current_line()
	local separator = line:match("%s$") and "" or " "
	local prefix_len = #line + #separator + #before

	vim.api.nvim_set_current_line(line .. separator .. before .. after)
	vim.api.nvim_win_set_cursor(0, { row, prefix_len })
	vim.cmd.startinsert()
end, { desc = "Comment: end of line" })

-- credits: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end

vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })
