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
nmap("<leader>v", ":vsp<CR><C-w><C-w>")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("<leader>.", ":cd ..<CR>")

nmap("<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<leader>m", ":set mouse=", { noremap = true })

vim.keymap.set("n", "<leader>s", ":%s/<c-r><c-w>/<C-r><C-w>/gI<Left><Left><Left>", {})
nmap("<leader>t", ":TSContextToggle<cr>")
nmap("<C-h>", ":tabp<cr>")
nmap("<C-l>", ":tabN<cr>")
nmap("-", ":tabm -1<cr>")
nmap("=", ":tabm +1<cr>")
nmap("<leader>z", ":tab split<cr>")
nmap("qq", ":q<cr>")
nmap("j", "gj")
nmap("k", "gk")

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
nmap("<leader>S", ":SSave")
nmap("<C-t>", ":tabnew<cr>")
nmap("H", "gT")
nmap("L", "gt")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

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

nmap("<leader>tw", ":TWValues<cr>")

vim.keymap.set("c", "<leader>dd", ":!rm -rf %")

vim.keymap.set("v", "<C-s>", ":'<,'>sort<cr>", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", opts)
vim.keymap.set("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", opts)
vim.keymap.set("v", "C-s", ":'<,'>sort<CR>", opts)

vim.keymap.set("v", "j", "gj", opts)
vim.keymap.set("v", "k", "gk", opts)

vim.keymap.set("v", "p", '"_dP', opts)

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

-- credits: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3
local function smart_dd()
	if vim.api.nvim_get_current_line():match("^%s*$") then
		return '"_dd'
	else
		return "dd"
	end
end

vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })
