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
vim.cmd([[hi @string ctermfg=228 guifg=#f1fa8c gui=bold]])
vim.cmd([[hi @keyword ctermfg=228 guifg=#30baf8 gui=bold]])
vim.cmd([[hi @function ctermfg=228 guifg=#ffe1ff gui=bold]])
vim.cmd([[hi @function.builtin ctermfg=228 guifg=#ffe1ff gui=italic]])
vim.cmd([[hi @constant ctermfg=228 guifg=#ff79c6 gui=italic,bold]])
vim.cmd([[hi @property ctermfg=228 guifg=#98ff98 gui=italic]])
vim.cmd([[hi @boolean ctermfg=228 guifg=#ab92b3 gui=italic,bold]])
vim.cmd([[hi @tag ctermfg=228 guifg=#bf9 gui=italic,bold]])
vim.cmd([[hi @include ctermfg=228 guifg=#12e781 gui=italic,bold]])
vim.cmd([[hi @parameter ctermfg=228 gui=italic]])
vim.cmd([[hi @type ctermfg=228 gui=italic,bold]])
vim.cmd([[hi @namespace ctermfg=228 gui=italic,bold]])
