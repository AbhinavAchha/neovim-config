local toggleterm = require("toggleterm")

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local opts = { noremap = true }
local map = vim.keymap.set
map("n", "<leader>tp", ":lua _PYTHON_TOGGLE()<cr>", opts)
map("n", "<leader>tn", ":lua _NODE_TOGGLE()<cr>", opts)
map("n", "<leader>th", ":lua _HTOP_TOGGLE()<cr>", opts)

function _G.set_terminal_keymaps()
	local bmap = vim.api.nvim_buf_set_keymap
	bmap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end
