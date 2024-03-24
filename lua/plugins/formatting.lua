local javascript = {
	function()
		return {
			exe = "prettierd",
			args = { vim.api.nvim_buf_get_name(0) },
			stdin = true,
		}
	end,
}

return {
	"mhartington/formatter.nvim",
	opts = function()
		vim.cmd(
			[[ autocmd BufWritePost *.js,*,mjs,*.cjs,*.rs,*.lua,*.tsx,*.ts,*.html,*.css,*.jsx,*.sh,*.py,*.sql,*.c FormatWrite ]]
		)
		return {
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
							args = { "-" },
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
				sql = {
					function()
						return {
							exe = "sql-formatter",
							args = { "--config", "~/.config/sql-formatter.json", "--fix" },
							stdin = false,
						}
					end,
				},
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any
					-- filetype
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		}
	end,
}
