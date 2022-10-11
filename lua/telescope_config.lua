local opts = { noremap = true, silent = true }
local map = vim.keymap.set

map("n", "<leader>ff", ":Telescope fd<cr>", opts)
map("n", "<leader>fb", ":Telescope file_browser<cr>", opts)
map("n", "<leader>ht", ":Telescope help_tags<cr>", opts)
map("n", "<leader>rg", ":Telescope live_grep<cr>", opts)
map("n", "<leader>fgc", ":Telescope git_commits<cr>", opts)
map("n", "<leader>fgs", ":Telescope git_status<cr>", opts)
map("n", "<leader>fm", ":Telescope man_pages<cr>", opts)
map("n", "<leader>/", ":Telescope search_history<cr>", opts)
map("n", "<leader>:", ":Telescope command_history<cr>", opts)
map("n", "<leader>k", ":Telescope keymaps<cr>", opts)
