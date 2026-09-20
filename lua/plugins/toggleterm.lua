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
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			callback = function(ev)
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buf = ev.buf })
			end,
		})

		local Terminal = require("toggleterm.terminal").Terminal

		local node = Terminal:new({ cmd = "node", hidden = true })
		local htop = Terminal:new({ cmd = "htop", hidden = true })
		local python = Terminal:new({ cmd = "python", hidden = true })
		local gomacro = Terminal:new({ cmd = "gomacro", hidden = true })
		local pgcli = Terminal:new({ cmd = "pgcli --dbname postgres", hidden = true })
		local calc = Terminal:new({ cmd = "calc", hidden = true })

		vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python REPL" })
		vim.keymap.set("n", "<leader>tn", function() node:toggle() end, { desc = "Toggle Node REPL" })
		vim.keymap.set("n", "<leader>th", function() htop:toggle() end, { desc = "Toggle htop" })
		vim.keymap.set("n", "<leader>tg", function() gomacro:toggle() end, { desc = "Toggle Go REPL" })
		vim.keymap.set("n", "<leader>ts", function() pgcli:toggle() end, { desc = "Toggle pgcli" })
		vim.keymap.set("n", "<leader>tc", function() calc:toggle() end, { desc = "Toggle calc" })
	end,

	keys = {},
}
