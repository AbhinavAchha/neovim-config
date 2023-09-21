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
-- " => Colorscheme section
------------------------------

local function set_colors()
	vim.cmd([[
    hi @string ctermfg=228 guifg=#f1fa8c gui=bold
	hi @keyword ctermfg=228 guifg=#30baf8 gui=bold
	hi @function ctermfg=228 guifg=#ffe1ff gui=bold
	hi @function.builtin ctermfg=228 guifg=#ffe1ff gui=italic
	hi @constant ctermfg=228 guifg=#ff79c6 gui=italic,bold
	hi @constant.builtin ctermfg=228 guifg=#ff79c6 gui=bold
	hi @property ctermfg=228 guifg=#98ff98 gui=italic
	hi @boolean ctermfg=228 guifg=#ab92b3 gui=italic,bold
	hi @tag ctermfg=228 guifg=#bf9 gui=italic,bold
	hi @include ctermfg=228 guifg=#12e781 gui=italic,bold
	hi @parameter ctermfg=228 gui=italic
	hi @type ctermfg=228 gui=italic,bold
	hi @namespace ctermfg=228 gui=italic,bold
	hi @method ctermfg=228 gui=bold
	hi @comment ctermfg=228 gui=italic guifg=#999999
	hi @repeat gui=bold guifg=#ffffff
	hi @operator gui=bold guifg=#ffffff
	hi @number gui=bold guifg=#ffffff
	hi @type gui=bold guifg=#ffa69e
    hi @method.call.go ctermfg=228 gui=bold
    " hi TabLine guibg=#bcbcbc
    " hi TabLineSel guibg=#2aa5a5
    ]])
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_colors,
})

set_colors()

-- vim.cmd([[colorscheme rigel]])
-- vim.cmd([[colorscheme duskfox]])
-- vim.cmd([[colorscheme tokyonight]])
vim.cmd.colorscheme("catppuccin")

-- vim.cmd([[colorscheme github_dark]])

vim.cmd([[
  autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
]])
