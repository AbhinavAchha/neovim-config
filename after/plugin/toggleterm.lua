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
map("n", "<leader>tg", ":lua _GO_TOGGLE()<cr>", opts)

function _G.set_terminal_keymaps()
	local bmap = vim.api.nvim_buf_set_keymap
	bmap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

function _NODE_TOGGLE()
	Terminal:new({ cmd = "node", hidden = true }).toggle()
end

function _HTOP_TOGGLE()
	Terminal:new({ cmd = "htop", hidden = true }).toggle()
end

function _PYTHON_TOGGLE()
	Terminal:new({ cmd = "python", hidden = true }).toggle()
end

function _GO_TOGGLE()
	Terminal:new({ cmd = "gomacro", hidden = true }):toggle()
end
