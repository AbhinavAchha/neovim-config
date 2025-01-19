return {
	"akinsho/toggleterm.nvim",

	opts = {
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
	},

	init = function()
		function _G.set_terminal_keymaps()
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], {})
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal

		function _NODE_TOGGLE()
			Terminal:new({ cmd = "node", hidden = true }):toggle()
		end

		function _HTOP_TOGGLE()
			Terminal:new({ cmd = "htop", hidden = true }):toggle()
		end

		function _PYTHON_TOGGLE()
			Terminal:new({ cmd = "python", hidden = true }):toggle()
		end

		function _GO_TOGGLE()
			Terminal:new({ cmd = "gomacro", hidden = true }):toggle()
		end

		function _PGCLI_TOGGLE()
			Terminal:new({ cmd = "pgcli --dbname postgres", hidden = true }):toggle()
		end

		function _CALC_TOGGLE()
			Terminal:new({ cmd = "calc", hidden = true }):toggle()
		end
	end,

	keys = {
		{ "<leader>tp", ":lua _PYTHON_TOGGLE()<cr>" },
		{ "<leader>tn", ":lua _NODE_TOGGLE()<cr>" },
		{ "<leader>th", ":lua _HTOP_TOGGLE()<cr>" },
		{ "<leader>tg", ":lua _GO_TOGGLE()<cr>" },
		{ "<leader>ts", ":lua _PGCLI_TOGGLE()<cr>" },
		{ "<leader>tc", ":lua _CALC_TOGGLE()<cr>" },
	},
}
