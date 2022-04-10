local opts = { noremap = true }
local map = vim.api.nvim_set_keymap

map("n", "<leader>ga", ":Git add %", opts)
map("n", "<leader>gA", ":Git add -A", opts)
map("n", "<leader>gc", ':Git commit -am ""<left>', opts)
map("n", "<leader>gca", ":Git commit -a --amend --no-edit", opts)
map("n", "<leader>gd", ":Git diff<cr>", opts)
map("n", "<leader>gl", ":Git log <cr>", opts)
map("n", "<leader>gn", ":Git rev-list --count HEAD<cr>", opts)
map("n", "<leader>gp", ":Git push<cr>", opts)
map("n", "<leader>gpf", ":Git push --force<cr>", opts)
map("n", "<leader>G", ":G<cr>", opts)
map("n", "<leader>gD", ":Git diff %<cr>", opts)
map("n", "<leader>gf", ":diffget //3<cr>", opts)
map("n", "<leader>gh", ":diffget //2<cr>", opts)
