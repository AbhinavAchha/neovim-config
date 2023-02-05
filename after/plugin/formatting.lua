local javascript = {
	function()
		return {
			exe = "prettier",
			args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
			stdin = true,
		}
	end,
}

require("formatter").setup({
	logging = false,
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
			function()
				return {
					exe = "black",
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
			function()
				return {
					exe = "shfmt",
					args = { "-i", 2 },
					stdin = true,
				}
			end,
		},
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd(
	[[ autocmd BufWritePost *.js,*,mjs,*.cjs,*.rs,*.lua,*.tsx,*.ts,*.html,*.css,*.jsx,*.sh,*.py,*.json FormatWrite ]]
)