require("spectre").setup()

vim.keymap.set("n", "<leader>S", ":lua require('spectre').open()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>s", ":lua require('spectre').open_file_search()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>sv", ":lua require('spectre').open_visual()<CR>", { noremap = true, silent = true })
