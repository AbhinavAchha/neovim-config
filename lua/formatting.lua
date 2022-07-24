local javascript = {
	-- prettier
	function()
		return {
			exe = "prettier",
			args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
			stdin = true,
		}
	end,
}

require("formatter").setup({
	filetype = {
		javascript = javascript,
		html = javascript,
		css = javascript,
		json = javascript,
		typescript = javascript,
		typescriptreact = javascript,
		javascriptreact = javascript,
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"-",
					},
					stdin = true,
				}
			end,
		},
		python = {
			-- Configuration for psf/black
			function()
				return {
					exe = "black", -- this should be available on your $PATH
					args = { "-" },
					stdin = true,
				}
			end,
			function()
				return {
					exe = "isort",
					args = { "-" },
					stdin = true,
				}
			end,
		},
		rust = {
			-- Rustfmt
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},
		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = "shfmt",
					args = { "-i", 2 },
					stdin = true,
				}
			end,
		},
		go = {
			function()
				return {
					exe = "golines",
					-- args = { "-w", vim.api.nvim_buf_get_name(0) },
					args = { "-m 80" },
					stdin = true,
				}
			end,
		},
	},
})

vim.cmd([[
autocmd BufWritePost *.js,*,mjs,*.cjs,*.rs,*.lua,*.tsx,*.ts,*.html,*.css,*.jsx,*.sh,*.py,*.go FormatWrite
]])
