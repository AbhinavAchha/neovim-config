local cmd = vim.cmd

cmd([[autocmd FileType text setlocal spell]])

-------------------------------
-- " => Python section
-------------------------------
cmd([[au FileType python inoremap <buffer> <C-p> print()<left>]])
cmd([[au FileType python nnoremap <leader>S :Semshi enable<CR>]])

------------------------------
-- " => JavaScript section
------------------------------

cmd([[au FileType javascript imap <buffer> <C-c> console.log();<left><left>]])
cmd([[au FileType typescript imap <buffer> <C-c> console.log();<left><left>]])
cmd([[au FileType typescriptreact imap <buffer> <C-c> console.log();<left><left>]])

------------------------------
-- " => HTML section
------------------------------

cmd([[au FileType html imap <buffer> <C-c> console.log();<esc>hi]])

------------------------------
-- " => Lua section
------------------------------

cmd([[au FileType lua nnoremap <leader>S :so!<CR>]])
