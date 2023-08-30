vim.cmd([[autocmd FileType text setlocal spell]])

-- https://neovim.io/doc/user/lua.html#lua-highlight
vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank()]])
-------------------------------
-- " => Python section
-------------------------------
vim.cmd([[au FileType python inoremap <buffer> <C-p> print()<left>]])
vim.cmd([[au FileType python nnoremap <leader>S :Semshi enable<CR>]])

------------------------------
-- " => JavaScript section
------------------------------

vim.cmd([[au FileType javascript imap <buffer> <C-c> console.log();<left><left>]])
vim.cmd([[au FileType typescript imap <buffer> <C-c> console.log();<left><left>]])
vim.cmd([[au FileType typescriptreact imap <buffer> <C-c> console.log();<left><left>]])

------------------------------
-- " => HTML section
------------------------------

vim.cmd([[au FileType html imap <buffer> <C-c> console.log();<esc>hi]])

------------------------------
-- " => Lua section
------------------------------

vim.cmd([[au FileType lua nnoremap <leader>S :so!<CR>]])

------------------------------
-- " => Colorscheme section
------------------------------

local function set_colors()
	vim.cmd([[hi @string ctermfg=228 guifg=#f1fa8c gui=bold]])
	vim.cmd([[hi @keyword ctermfg=228 guifg=#30baf8 gui=bold]])
	vim.cmd([[hi @function ctermfg=228 guifg=#ffe1ff gui=bold]])
	vim.cmd([[hi @function.builtin ctermfg=228 guifg=#ffe1ff gui=italic]])
	vim.cmd([[hi @constant ctermfg=228 guifg=#ff79c6 gui=italic,bold]])
	vim.cmd([[hi @constant.builtin ctermfg=228 guifg=#ff79c6 gui=bold]])
	vim.cmd([[hi @property ctermfg=228 guifg=#98ff98 gui=italic]])
	vim.cmd([[hi @boolean ctermfg=228 guifg=#ab92b3 gui=italic,bold]])
	vim.cmd([[hi @tag ctermfg=228 guifg=#bf9 gui=italic,bold]])
	vim.cmd([[hi @include ctermfg=228 guifg=#12e781 gui=italic,bold]])
	vim.cmd([[hi @parameter ctermfg=228 gui=italic]])
	vim.cmd([[hi @type ctermfg=228 gui=italic,bold]])
	vim.cmd([[hi @namespace ctermfg=228 gui=italic,bold]])
	vim.cmd([[hi @method ctermfg=228 gui=bold]])
	vim.cmd([[hi @comment ctermfg=228 gui=italic guifg=#999999]])
	vim.cmd([[hi @repeat gui=bold guifg=#ffffff]])
	vim.cmd([[hi @operator gui=bold guifg=#ffffff]])
	vim.cmd([[hi @number gui=bold guifg=#ffffff]])
	vim.cmd([[hi @type gui=bold guifg=#ffa69e]])
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_colors,
})

set_colors()

-- vim.cmd([[colorscheme rigel]])
-- vim.cmd([[colorscheme duskfox]])
vim.cmd([[colorscheme tokyonight]])

-- vim.cmd([[colorscheme github_dark]])

vim.g.highlightedyank_highlight_duration = 200
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
