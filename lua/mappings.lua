local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
local function nmap(key, cmd)
	map("n", key, cmd, opts)
end

map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

nmap("0", "^")
nmap("<leader>w", ":w<cr>")
nmap("'", "`")
nmap("<leader>e", ":e%<cr>")
nmap("<leader>A", "ggVG")
nmap("<leader>Q", ":qa!<cr>")
nmap("Q", "<NOP>")
nmap("<leader>v", ":vsp<cr><C-w><C-w>")
nmap("<leader>r", ":source ~/.config/nvim/init.lua<cr>")
nmap("<leader>v", ":vsp<CR><C-w><C-w>")
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("<leader>.", ":cd ..<CR>")

map("n", "<leader>s", ":%s/<c-r><c-w>//<Left>", {})
map("n", "<leader>m", ":set mouse=", { noremap = true })

-- nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
map("n", "<leader>s", ":%s/<c-r><c-w>/<C-r><C-w>/gI<Left><Left><Left>", {})
nmap("gG", "g<C-g>")
nmap("<leader>T", ":TSEnableAll highlight<cr>")
nmap("<C-h>", ":tabp<cr>")
nmap("<C-l>", ":tabN<cr>")
nmap("-", ":tabm -1<cr>")
nmap("=", ":tabm +1<cr>")
nmap("<leader>z", ":tab split<cr>")
nmap("<leader>q", ":q<cr>")
nmap("<leader>`", ":q!<cr>")
nmap("qq", ":q<cr>")
nmap("j", "gj")
nmap("k", "gk")

nmap("<leader>1", "1gt")
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

map("t", "<Esc>", "<C-\\><C-n>", opts)

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

map("v", "<C-s>", ":'<,'>sort<cr>", opts)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("v", "<M-j>", ":m'>+<cr>`<my`>mzgv`yo`z", opts)
map("v", "<M-k>", ":m'<-2<cr>`>my`<mzgv`yo`z", opts)
map("v", "C-s", ":'<,'>sort<CR>", opts)

map("v", "j", "gj", opts)
map("v", "k", "gk", opts)

map("v", "p", '"_dP', opts)
map("v", "<leader>gG", "g<C-g>", opts)
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
